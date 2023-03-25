(function () {
  "use strict";

  window._stateSet = function () {
    window._stateSet = function () {
      console.log("Call _stateSet only once");
    };

    let appState = window._appState;

    let valueField = document.querySelector("#value");
    let updateState = function () {
      valueField.value = appState.count;
    };

    //Register a callback to update the HTML  field from Flutter
    appState.addHandler(updateState);

    //Render the first value -- 0
    updateState();

    let incrementButton = document.querySelector("#increment");
    incrementButton.addEventListener("click", (event) => {
      appState.increaseCount();
    });
    

    let decrementButton = document.querySelector("#decrement");
    decrementButton.addEventListener("click", (event) => {
      appState.decreaseCount();
    });
    

    let resetButton = document.querySelector("#reset");
    resetButton.addEventListener("click", (event) => {
      appState.reset();
    });
    //ADD decrement Function here 
  

   


  };
})();
