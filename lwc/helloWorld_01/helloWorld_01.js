import { LightningElement } from 'lwc';

export default class HelloWorld extends LightningElement {

  greeting = 'World';
  variable01 = 'Great';

  changeHandler(event) {
    this.greeting = event.target.value;
  }

  changeHandler01(event) {
    this.variable01 = event.target.value;
  }

}