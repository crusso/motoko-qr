/**
 * Module     : version.mo
 * Copyright  : 2020 DFINITY Stiftung
 * License    : Apache 2.0 with LLVM Exception
 * Maintainer : Enzo Haussecker <enzo@dfinity.org>
 * Stability  : Stable
 */

import Galois "galois";
import List "mo:stdlib/list";
import Nat "nat";
import Prelude "mo:stdlib/prelude";
import Util "util";

module {

  type List<T> = List.List<T>;

  public type Version = { #Version : Nat };

  public func unbox(version : Version) : Nat {
    let #Version n = version;
    n
  };

  public func encode(version : Version) : List<Bool> {
    let input = Nat.natToBits(unbox(version));
    let poly1 = Galois.polyFromBits(Util.padRight(12, input));
    let poly2 = Galois.polyFromBits(Nat.natToBits(7973));
    Util.padLeftTo(18, Galois.polyToBits(Galois.polyAdd(poly1, Galois.polyDivMod(poly1, poly2).1)))
  };

}
