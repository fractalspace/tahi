# Test IP6Interop.1.4 Part B

# scenario
scenario interop {
    setup_cleanup_REF1;
    setup_cleanup_REF2;
    setup_DUMPER;
    setup_cleanup_TEST-TAR-HOST;

    test_TEST-TAR-HOST;
    test_REF2;

    cleanup_DUMPER;
}

# syncevent
syncevent start_setup setup_cleanup_REF1, setup_cleanup_REF2, setup_DUMPER, setup_cleanup_TEST-TAR-HOST;
syncevent finish_setup setup_cleanup_REF1, setup_cleanup_REF2, cleanup_DUMPER, setup_cleanup_TEST-TAR-HOST, test_TEST-TAR-HOST;
syncevent start_test test_TEST-TAR-HOST, test_REF2;
syncevent finish_test setup_cleanup_REF1, setup_cleanup_REF2, setup_cleanup_TEST-TAR-HOST, cleanup_DUMPER, test_TEST-TAR-HOST, test_REF2;

syncevent sync_step4_1 test_TEST-TAR-HOST, test_REF2;
syncevent sync_step4_2 test_TEST-TAR-HOST, test_REF2;
syncevent sync_step5_1 test_TEST-TAR-HOST, test_REF2;
syncevent sync_step5_2 test_TEST-TAR-HOST, test_REF2;
syncevent sync_step7_1 test_TEST-TAR-HOST, test_REF2;
syncevent sync_step7_2 test_TEST-TAR-HOST, test_REF2;
syncevent sync_step8_1 test_TEST-TAR-HOST, test_REF2;
syncevent sync_step8_2 test_TEST-TAR-HOST, test_REF2;
syncevent sync_step10_1 test_TEST-TAR-HOST, test_REF2;
syncevent sync_step10_2 test_TEST-TAR-HOST, test_REF2;
syncevent sync_step11_1 test_TEST-TAR-HOST, test_REF2;
syncevent sync_step11_2 test_TEST-TAR-HOST, test_REF2;

# waitevent
waitevent wait_show_topology setup_cleanup_REF1;

waitevent wait_step4_1 test_TEST-TAR-HOST;
waitevent wait_step4_2 test_TEST-TAR-HOST;
waitevent wait_step5 test_REF2;
waitevent wait_step7_1 test_TEST-TAR-HOST;
waitevent wait_step7_2 test_TEST-TAR-HOST;
waitevent wait_step8 test_REF2;
waitevent wait_step10_1 test_TEST-TAR-HOST;
waitevent wait_step10_2 test_TEST-TAR-HOST;
waitevent wait_step11 test_REF2;


# test command
command test_TEST-TAR-HOST TEST-TAR-HOST {
    sync finish_setup;
    
    sync start_test;

    # Step 4
    sync sync_step4_1;
    print "";
    print "BASENAME> Step 4 1/2 (Spec)";
    print "BASENAME> Configure YOUR DEVICE to transmit Router Advertisements with";
    print "BASENAME> Router Lifetime set to 0 second and at a normal interval on Network 1,";
    print "BASENAME> and Router Lifetime greater than the Router Advertisement Interval"; 
    print "BASENAME> on Network 2.";
    print "BASENAME> Press Enter key for continue.";
    wait wait_step4_1;

    execute "TEST-TAR-HOST_CMD_RTSOL_IF1";

    print "BASENAME> Step 4 2/2 (Spec)";
    print "BASENAME> Allow time for TEST-TAR-HOST_NAME to receive Router Advertisement on Network1.";
    print "BASENAME> Press Enter key for continue.";
    wait wait_step4_2;
    sync sync_step4_2;

    # Step 5
    sync sync_step5_1;
    sync sync_step5_2;

    # Step 7
    sync sync_step7_1;
    print "";
    print "BASENAME> Step 7 1/2 (Spec)";
    print "BASENAME> Configure YOUR DEVICE to transmit Router Advertisements with";
    print "BASENAME> Router Lifetime set to 600 second and at a normal interval on Network 1,";
    print "BASENAME> and Router Lifetime greater than the Router Advertisement Interval"; 
    print "BASENAME> on Network 2.";
    print "BASENAME> Press Enter key for continue.";
    wait wait_step7_1;

    execute "TEST-TAR-HOST_CMD_RTSOL_IF1";

    print "BASENAME> Step 7 2/2 (Spec)";
    print "BASENAME> Allow time for TEST-TAR-HOST_NAME to receive Router Advertisement on Network1.";
    print "BASENAME> Press Enter key for continue.";
    wait wait_step7_2;
    sync sync_step7_2;

    # Step 8
    sync sync_step8_1;
    sync sync_step8_2;

    # Step 10
    sync sync_step10_1;
    print "";
    print "BASENAME> Step 10 1/2 (Spec)";
    print "BASENAME> Configure YOUR DEVICE to transmit Router Advertisements with";
    print "BASENAME> Router Lifetime set to 0 second and at a normal interval on Network 1,";
    print "BASENAME> and Router Lifetime greater than the Router Advertisement Interval"; 
    print "BASENAME> on Network 2.";
    print "BASENAME> Press Enter key for continue.";
    wait wait_step10_1;

    execute "TEST-TAR-HOST_CMD_RTSOL_IF1";

    print "BASENAME> Step 10 2/2 (Spec)";
    print "BASENAME> Allow time for TEST-TAR-HOST_NAME to receive Router Advertisement on Network1.";
    print "BASENAME> Press Enter key for continue.";
    wait wait_step10_2;
    sync sync_step10_2;

    # Step 11
    sync sync_step11_1;
    sync sync_step11_2;

    sync finish_test;
}

command test_REF2 REF2 {
    sync start_test;

    # Step 4
    sync sync_step4_1;
    sync sync_step4_2;

    # Step 5
    sync sync_step5_1;
    print "";
    print "BASENAME> Step 5 (Spec)";
    print "BASENAME> REF2 transmits ICMPv6 Echo Request to the Global Address of the TEST-TAR-HOST_NAME.";
    print "BASENAME> Press Enter key.";
    print "";
    wait wait_step5;

    delay 1;
    REF2_CMD_CLEAR_NCE_IF1;
    REF2_CMD_PRINT_NCE_IF1;
    REF2_CMD_CLEAR_NCE_IF2;
    REF2_CMD_PRINT_NCE_IF2;
    execute "/bin/sh -c ping6 -c 5 TEST-TAR-HOST_IF1_PREFIX1_GA | tee /tmp/1.4.B.REF.TEST-TAR-HOST_NAME.result";
    delay 1;
    sync sync_step5_2;

    # Step 7
    sync sync_step7_1;
    sync sync_step7_2;

    # Step 8
    sync sync_step8_1;
    print "";
    print "BASENAME> Step 8 (Spec)";
    print "BASENAME> REF2 transmits ICMPv6 Echo Request to the Global Address of the TEST-TAR-HOST_NAME.";
    print "BASENAME> Press Enter key.";
    print "";
    wait wait_step8;

    delay 1;
    REF2_CMD_CLEAR_NCE_IF1;
    REF2_CMD_PRINT_NCE_IF1;
    REF2_CMD_CLEAR_NCE_IF2;
    REF2_CMD_PRINT_NCE_IF2;
    execute "/bin/sh -c ping6 -c 5 TEST-TAR-HOST_IF1_PREFIX1_GA | tee -a /tmp/1.4.B.REF.TEST-TAR-HOST_NAME.result";
    delay 1;
    sync sync_step8_2;

    # Step 10
    sync sync_step10_1;
    sync sync_step10_2;

    # Step 11
    sync sync_step11_1;
    print "";
    print "BASENAME> Step 11 (Spec)";
    print "BASENAME> REF2 transmits ICMPv6 Echo Request to the Global Address of the TEST-TAR-HOST_NAME.";
    print "BASENAME> Press Enter key.";
    print "";
    wait wait_step11;

    delay 1;
    REF2_CMD_CLEAR_NCE_IF1;
    REF2_CMD_PRINT_NCE_IF1;
    REF2_CMD_CLEAR_NCE_IF2;
    REF2_CMD_PRINT_NCE_IF2;
    execute "/bin/sh -c ping6 -c 5 TEST-TAR-HOST_IF1_PREFIX1_GA | tee -a /tmp/1.4.B.REF.TEST-TAR-HOST_NAME.result";
    delay 1;
    sync sync_step11_2;

    sync finish_test;
}

# setup command
## REF1(REF1_NAME) is disable
command setup_cleanup_REF1 REF1 {

    # show topology
    print "This test uses active node as described below.";
    print "";
    print "1.4 (Router vs Host)";
    print "                                    Network 1";
    print "      ---------------------+-----------+------+-";
    print "                           |           |      |";
    print "                           |           | 1    +-------------+";
    print "                           |        +------+                |";
    print "                           |        | LOGO | (Router)       |";
    print "                           |        +------+                |";
    print "                           |           |                    |";
    print "                           |           |   Network 2        |";
    print "      -------------+-------------------+-----+--            |";
    print "                   |       |                 |              |";
    print "                 1 |       |                 +------+       |";
    print "         TG +----------+   |                        |       |";
    print "   +--------| REF-2 (V)|   |                        |       |";
    print "   |        +----------+   |                        |       |";
    print "   |                       |                        |       |";
    print "   |                       |                        |       |";
    print "   |                       |                        |       |";
    print "   |                       |                        |       |";
    print "   |                       |                        |       |";
    print "   |  TG +----------+ 1    |                        |       |";
    print "   | +---| TAR* (V) |------+                        |       |";
    print "   | |   +----------+                               |       |";
    print "   | |     (Router)                                 |       |";
    print "   | |                                              |       |";
    print "   | |                                              |       |";
    print "   | |                                              | 2     |";
    print "   | |     Network for TG                      +---------+  |";
    print "---+-+----+-------+-                           | dump (V)|--+";
    print "          |       |                            +---------+ 1";
    print "       TG |       |                                 | TG";
    print "    +---------+   +---------------------------------+";
    print "    | vel mgr |";
    print "    +---------+";
    print "";
    print "(V) means vel agent is running.";
    print "";
    print "BASENAME> Press Enter key to start test.";
    wait wait_show_topology;
    #

    sync start_setup;

    execute "REF1_CMD_SYSCTL_NOT_ACCEPT_RA";
    execute "REF1_CMD_SYSCTL_NOT_FORWARDING";
    execute "REF1_CMD_IFCONFIG_IF1_DOWN";
    execute "REF1_CMD_IFCONFIG_IF2_DOWN";
    sync finish_setup;

    sync finish_test;
}

## REF2(REF2_NAME) runs as host
command setup_cleanup_REF2 REF2 {
    sync start_setup;

    execute "REF2_CMD_SYSCTL_ACCEPT_RA";
    execute "REF2_CMD_SYSCTL_NOT_FORWARDING";
    execute "REF2_CMD_IFCONFIG_IF1_UP";
    execute "REF2_CMD_IFCONFIG_IF2_DOWN";
    execute "REF2_CMD_RTSOL_IF1";

    delay 2;

    sync finish_setup;

    sync finish_test;

    execute "REF2_CMD_SYSCTL_NOT_ACCEPT_RA";
    execute "REF2_CMD_SYSCTL_NOT_FORWARDING";
    REF2_CMD_CLEAR_NCE_IF1;
    REF2_CMD_PRINT_NCE_IF1;
    REF2_CMD_CLEAR_NCE_IF2;
    REF2_CMD_PRINT_NCE_IF2;
    execute "REF2_CMD_IFCONFIG_IF1_DOWN";
    execute "REF2_CMD_IFCONFIG_IF2_DOWN";
    execute "REF2_CMD_IFCONFIG_IF1_PREFIX2_GA_DELETE";
}

command setup_DUMPER DUMPER {
    delay 5;
    sync start_setup;
    execute "/bin/sh -c /usr/sbin/tcpdump -i DUMPER_IF1 -c 10000 -s 0 -w /tmp/1.4.B.LOGO_NAME.TEST-TAR-HOST_NAME.Network1.dump&";
    execute "/bin/sh -c /usr/sbin/tcpdump -i DUMPER_IF2 -c 10000 -s 0 -w /tmp/1.4.B.LOGO_NAME.TEST-TAR-HOST_NAME.Network2.dump&";
}

command cleanup_DUMPER DUMPER {
    delay 10;
    sync finish_setup;
    sync finish_test;
    delay 5;
    execute "killall tcpdump";
}

## TEST-TAR-HOST_TYPE(TEST-TAR-HOST_NAME)
command setup_cleanup_TEST-TAR-HOST TEST-TAR-HOST {
    sync start_setup;

    execute "TEST-TAR-HOST_CMD_SYSCTL_NOT_FORWARDING";
    execute "TEST-TAR-HOST_CMD_SYSCTL_ACCEPT_RA";
    execute "TEST-TAR-HOST_CMD_IFCONFIG_IF1_UP";
    execute "TEST-TAR-HOST_CMD_IFCONFIG_IF2_DOWN";
    execute "TEST-TAR-HOST_CMD_RTSOL_IF1";

    delay 2;

    sync finish_setup;

    sync finish_test;
    execute "TEST-TAR-HOST_CMD_IFCONFIG_IF1_DOWN";
    execute "TEST-TAR-HOST_CMD_IFCONFIG_IF1_LLA_DELETE";
    execute "TEST-TAR-HOST_CMD_IFCONFIG_IF1_PREFIX1_GA_DELETE";
    execute "TEST-TAR-HOST_CMD_IFCONFIG_IF2_DOWN";
    execute "TEST-TAR-HOST_CMD_SYSCTL_NOT_ACCEPT_RA";
    execute "TEST-TAR-HOST_CMD_SYSCTL_NOT_FORWARDING";
    execute "TEST-TAR-HOST_CMD_FLUSH_ROUTE_PREFIX1_IF1";
    execute "TEST-TAR-HOST_CMD_FLUSH_ROUTE_PREFIX2_IF2";
    execute "TEST-TAR-HOST_CMD_FLUSH_PREFIX_LIST";
}
