function sellPrice() {

  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");


  priceInput.addEventListener('input', () => {
    const inputValue = priceInput.value;
    const tax = Math.floor(inputValue * 0.1);
    addTaxDom.innerHTML = tax;
    profitDom.innerHTML = Math.floor(inputValue - tax);  
 })
}

window.addEventListener('load', sellPrice)