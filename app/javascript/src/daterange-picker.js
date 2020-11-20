import Litepicker from "litepicker";

document.addEventListener("DOMContentLoaded", () => {
  const startDate = document.getElementById("start-date");
  const endDate = document.getElementById("end-date");

  if (startDate && endDate) {
    var picker = new Litepicker({
      element: startDate,
      elementEnd: endDate,
      singleMode: false,
    });
  }
});
