import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display-price"
export default class extends Controller {
  static targets = ["start_date", "end_date", "price", "info"];
  static values = { price: Number };

  connect() {
    console.log("hello");
  }

  update() {
    const pricePerDay = parseInt(this.priceValue, 10);

    if (
      this.start_dateTarget.value !== "" &&
      this.end_dateTarget.value !== ""
    ) {
      const diffInMs =
        new Date(this.end_dateTarget.value) -
        new Date(this.start_dateTarget);
      const diffInDays = diffInMs / (1000 * 60 * 60 * 24);
      if (diffInDays > 0) {
        this.infoTarget.innerText = `¥${pricePerDay} x ${diffInDays} days`;
        this.priceTarget.innerHTML = `<span>¥${(
          diffInDays * pricePerDay
        ).toLocaleString()}</span> <small class='fw-light'>total</small>`;
      } else if (diffInDays === 0) {
        this.infoTarget.innerText = "";
        this.priceTarget.innerHTML =
          "<span class='text-danger fw-light'>1-day minimum</span>";
      } else {
        this.infoTarget.innerText = "";
        this.priceTarget.innerHTML =
         "<span class='text-danger fw-light'>Invalid dates</span>";
      }
    }
  }
}
