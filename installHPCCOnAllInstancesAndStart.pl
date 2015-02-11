#!/usr/bin/perl
=pod

 perl installHPCCOnAllInstancesAndStart.pl public_ips.txt private_ips.txt ec2-user tlh_keys_us_west_2.pem

=cut
 
require "getConfigurationFile.pl";
=pod
 ENVIRONMENT VARIABLES USED BY THIS PROGRAM
 my $public_ips = $ARGV[0];
 my $private_ips = $ARGV[1];
 my $user = $ARGV[2];
 my $pem = $ARGV[3];
=cut

my $outfolder="/home/$user";
 
open(IN, $public_ips) || die "Can't open for input: \"$public_ips\"\n";
 
my $ecp_ip='';
my @public_ips=();
while(<IN>){
   next if /^#/ || /^\s*$/;
   chomp;
   my $ip=$_;
   push @public_ips, $ip;
   $esp_ip=$ip if $. == 1;
   $nInstances++;
    
   print("ssh -t -i $pem $user\@$ip \"bash $outfolder/install_hpcc.sh\"\n");
   system("ssh -t -i $pem $user\@$ip \"bash $outfolder/install_hpcc.sh\"");
}
 
my $nSupport = 1;
my $nNonSupport = ($nInstances==1)? 1 : $nInstances-1;
 
# On esp, configure hpcc with 1 thor slave node per instance. NOTE. VERY IMPORTANT THAT THIS INITIAL CONFIGURE HAS ONLY 1 NODE PER
print("ssh -t -i $pem $user\@$esp_ip \"bash configureHPCCOnly.sh $private_ips $created_environment_file $nSupport $nNonSupport 0 1\"\n");
system("ssh -t -i $pem $user\@$esp_ip \"bash configureHPCCOnly.sh $private_ips $created_environment_file $nSupport $nNonSupport 0 1\"");

#Start HPCC on all instances. But, with the master the last to start
for( my $i=$#public_ips; $i >= 0; $i--){ 
  my $ip=$public_ips[$i];
  print("ssh -t -i $pem $user\@$ip \"sudo service hpcc-init start\"\n");
  system("ssh -t -i $pem $user\@$ip \"sudo service hpcc-init start\"");
}


 
