import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";


actor Token {

    var owner: Principal = Principal.fromText("ejqzj-k7tjg-5aldz-4ieqx-hs2l2-aq3r2-ddskh-ylrsa-m3gnd-ozb3u-7ae");
    var totalSupply : Nat = 1000000000;
    var symbol : Text = "VLKV";

    var balances= HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
    balances.put(owner, totalSupply);

    public query func balanceOf(who: Principal) : async Nat {
       let balance : Nat = switch (balances.get(who)) {
        case null 0;
        case (?result) result;
       };
        
        return balance;
        
    };

    public query func getSymbol() : async Text{
        return symbol;
    };

    public shared(msg) func payOut(): async Text {
        // Debug.print(debug_show(msg.caller));
        if (balances.get(msg.caller) == null) {
            let amount = 10000;
            balances.put(msg.caller, amount);
            return "Success";
        } else {
            return "Already Claimed";
        };
        
    };

    public shared(msg) func transfer(to: Principal, amount: Nat): async Text {
        let fromBallance = await balanceOf(msg.caller);
        if (fromBallance >= amount) {
            let newFromBallance : Nat = fromBallance - amount;
            balances.put(msg.caller, newFromBallance);

            let toBalance = await balanceOf(to);
            let newToBalance = toBalance + amount;
            balances.put(to, newToBalance);

            return "Success";
        } else {
            return "Insufficient Funds"
        };

        
    };
}