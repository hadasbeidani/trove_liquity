#[starknet::contract] 
mod trove {
 
use starknet::{ContractAddress, get_caller_address}; //  , storage_access::StorageBaseAddress

#[derive(Drop, Serde, starknet::Store)]
pub struct Trove {                                  //pub ??
    debt: felt252,                                  // in solidity its uint256 ?? what to do ??
    coll: felt252,
    stake: felt252,
    //Status status                                  i need to add it , its from solidity now
    arrayIndex: u128,                               // in solidity its uint128 ?? what to do ??
}
#[storage]
// Store the necessary data for a trove
struct Storage {
    Troves: LegacyMap::<ContractAddress, Trove>
}  
#[external(v0)]
fn decreaseTroveDebt(ref self: ContractState, _borrower: ContractAddress, _debtDecrease: felt252) -> felt252 {
     self.Troves.write(_borrower, Trove {debt: self.Troves.read(_borrower).debt - _debtDecrease, ..self.Troves.read(_borrower)});
     self.Troves.read(_borrower).debt  //בלי נקודותייים ערך מוחזר(אחרת שגיאה)
} 
}
fn main() -> u32 {
    fib(16)
}

fn fib(mut n: u32) -> u32 {
    let mut a: u32 = 0;
    let mut b: u32 = 1;
    while n != 0 {
        n = n - 1;
        let temp = b;
        b = a + b;
        a = temp;
    };
    a
}

#[cfg(test)]
mod tests {
    use super::fib;

    #[test]
    fn it_works() {
        assert(fib(16) == 987, 'it works!');
    }
}
