module Sync : Test_common.EFF with type 'a io = 'a = struct
  include Plist_xml

  let opendir = Unix.opendir
  let readdir = Unix.readdir
  let closedir = Unix.closedir

  let bind x f = f x
  let return x = x

  let with_stream str f =
    let chan = open_in str in
    Fun.protect (fun () -> f (Markup.channel chan))
      ~finally:(fun () -> close_in chan)

  let catch f handle = try f () with exn -> handle exn

  let protect = Fun.protect

  let print_endline = print_endline
end

open Test_common.Make(Sync)

let () =
  prerr_endline "Test pass...";
  test_pass ();
  prerr_endline "Test fail...";
  test_fail ()