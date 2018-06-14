import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'transactionddoosunt'
})
export class TransactionddoosuntPipe implements PipeTransform {

  transform(value: any): any {
    return value.reduce((a, b) => a + b.outputs.reduce((c, d) => c + parseInt(d.coins, 10), 0), 0);
  }
}
