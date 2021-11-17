let
  arrakis = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIOSrAgjlB6X6S1EKx/PTwA8sh+fpdFOsu0ZI/bWWq5 root@arrakis";
  rakis = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILAtrWwUuEENiqU5L4DHx1v7JPQhX7wmLk728jfOLjn4 root@nixos";
  chapterhouse = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEFDl2VfaujPdouzZ+CXLy04puRRYrlBcvIRekuH2Beq root@chapterhouse";
  user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOPMGWAQcqtjQtZcAvKZACVLS3a8CI+TKGTSrw7Ukoql janus@dark.fi";
  janus = [ arrakis chapterhouse rakis user ];
in
{
  "janus.age".publicKeys = janus;
  "root.age".publicKeys = janus;
  "salusa.age".publicKeys = janus;
}
