require 'formula'

class Ntop <Formula
  url 'http://sourceforge.net/projects/ntop/files/ntop/ntop-4.0.1/ntop-4.0.1.tar.gz'
  homepage 'http://www.ntop.org'
  md5 '22f916327f0e92d8c470aaadcb80d84d'

  depends_on 'gdbm'
  depends_on 'rrdtool'
  depends_on 'geoip'

  # ntop aborts with an error upon startup if these empty directories are stripped
  skip_clean "lib/plugins"
  skip_clean "var/ntop"

  def patches
    # patches work around dyld missing symbols errors:
    # upon compilation _static_ntop, _usage and _welcome are moved
    # from main.c to plugin.c and prefs.c respectively
    # upon linking admin.c is moved from executable ntop to libntop.dylib
    DATA
  end

  def install
    system "./autogen.sh", "--noconfig"
    # override default locale /usr/lib/locale
    ENV['LOCALEDIR'] = '/usr/share/locale/'
    # don't add /opt on Mac OS X
    inreplace 'configure', '-L/opt/local/lib', ""
    inreplace 'configure', '-I/opt/local/include', ""
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end

__END__
diff --git a/main.c b/main.c
index bcdd4eb..dc24e06 100644
--- a/main.c
+++ b/main.c
@@ -38,155 +38,6 @@ extern char ** environ;
 #include <execinfo.h>
 #endif
 
-char static_ntop;
-
-/*
- * Hello World! This is ntop speaking...
- */
-void welcome (FILE * fp) {
-  fprintf (fp, "Welcome to %s v.%s (%d bit)\n"
-	   "[Configured on %s, built on %s]\n",
-	   myGlobals.program_name, version, sizeof(long) == 8 ? 64 : 32,
-	   configureDate, buildDate);
-
-  fprintf (fp, "Copyright 1998-2010 by %s.\n", author);
-  fprintf (fp, "Get the freshest ntop from http://www.ntop.org/\n");
-}
-
-
-/*
- * Wrong. Please try again accordingly to ....
- */
-void usage(FILE * fp) {
-  char *newLine = "";
-
-#ifdef WIN32
-  newLine = "\n\t";
-#endif
-
-  welcome(fp);
-
-  fprintf(fp, "\nUsage: %s [OPTION]\n\n", myGlobals.program_name);
-  fprintf(fp, "Basic options:\n");
-  fprintf(fp, "    [-h             | --help]                             %sDisplay this help and exit\n", newLine);
-#ifndef WIN32
-  fprintf(fp, "    [-u <user>      | --user <user>]                      %sUserid/name to run ntop under (see man page)\n", newLine);
-#endif /* WIN32 */
-  fprintf(fp, "    [-t <number>    | --trace-level <number>]             %sTrace level [0-6]\n", newLine);
-  fprintf(fp, "    [-P <path>      | --db-file-path <path>]              %sPath for ntop internal database files\n", newLine);
-  fprintf(fp, "    [-Q <path>      | --spool-file-path <path>]           %sPath for ntop spool files\n", newLine);
-  fprintf(fp, "    [-w <port>      | --http-server <port>]               %sWeb server (http:) port (or address:port) to listen on\n", newLine);
-#ifdef HAVE_OPENSSL
-  fprintf(fp, "    [-W <port>      | --https-server <port>]              %sWeb server (https:) port (or address:port) to listen on\n", newLine);
-#endif
-
-
-  fprintf(fp, "\nAdvanced options:\n");
-  fprintf(fp, "    [-4             | --ipv4]                             %sUse IPv4 connections\n",newLine);
-  fprintf(fp, "    [-6             | --ipv6]                             %sUse IPv6 connections\n",newLine);
-  fprintf(fp, "    [-a <file>      | --access-log-file <file>]           %sFile for ntop web server access log\n", newLine);
-  fprintf(fp, "    [-b             | --disable-decoders]                 %sDisable protocol decoders\n", newLine);
-  fprintf(fp, "    [-c             | --sticky-hosts]                     %sIdle hosts are not purged from memory\n", newLine);
-
-#ifndef WIN32
-  fprintf(fp, "    [-d             | --daemon]                           %sRun ntop in daemon mode\n", newLine);
-#endif
-  fprintf(fp, "    [-e <number>    | --max-table-rows <number>]          %sMaximum number of table rows to report\n", newLine);
-  fprintf(fp, "    [-f <file>      | --traffic-dump-file <file>]         %sTraffic dump file (see tcpdump)\n", newLine);
-  fprintf(fp, "    [-g             | --track-local-hosts]                %sTrack only local hosts\n", newLine);
-
-
-#ifndef WIN32
-  fprintf(fp, "    [-i <name>      | --interface <name>]                 %sInterface name or names to monitor\n", newLine);
-#else
-  fprintf(fp, "    [-i <number>    | --interface <number|name>]          %sInterface index number (or name) to monitor\n", newLine);
-#endif
-  fprintf(fp, "    [-j             | --create-other-packets]             %sCreate file ntop-other-pkts.XXX.pcap file\n", newLine);
-  fprintf(fp, "    [-l <path>      | --pcap-log <path>]                  %sDump packets captured to a file (debug only!)\n", newLine);
-  fprintf(fp, "    [-m <addresses> | --local-subnets <addresses>]        %sLocal subnetwork(s) (see man page)\n", newLine);
-  fprintf(fp, "    [-n             | --numeric-ip-addresses]             %sNumeric IP addresses - no DNS resolution\n", newLine);
-  fprintf(fp, "    [-o             | --no-mac]                           %sntop will trust just IP addresses (no MACs)\n", newLine);
-  fprintf(fp, "    [-p <list>      | --protocols <list>]                 %sList of IP protocols to monitor (see man page)\n", newLine);
-  fprintf(fp, "    [-q             | --create-suspicious-packets]        %sCreate file ntop-suspicious-pkts.XXX.pcap file\n", newLine);
-  fprintf(fp, "    [-r <number>    | --refresh-time <number>]            %sRefresh time in seconds, default is %d\n",
-	  newLine, DEFAULT_NTOP_AUTOREFRESH_INTERVAL);
-  fprintf(fp, "    [-s             | --no-promiscuous]                   %sDisable promiscuous mode\n", newLine);
-
-
-  fprintf(fp, "    [-x <max num hash entries> ]                          %sMax num. hash entries ntop can handle (default %u)\n",
-	  newLine, myGlobals.runningPref.maxNumHashEntries);
-  fprintf(fp, "    [-z             | --disable-sessions]                 %sDisable TCP session tracking\n", newLine);
-  fprintf(fp, "    [-A]                                                  %sAsk admin user password and exit\n", newLine);
-  fprintf(fp, "    [               | --set-admin-password=<pass>]        %sSet password for the admin user to <pass>\n", newLine);
-  fprintf(fp, "    [               | --w3c]                              %sAdd extra headers to make better html\n", newLine);
-  fprintf(fp, "    [-B <filter>]   | --filter-expression                 %sPacket filter expression, like tcpdump (for all interfaces)\n", newLine);
-  fprintf(fp, "                                                          %sYou can also set per-interface filter: \n", newLine);
-  fprintf(fp, "                                                          %seth0=tcp,eth1=udp ....\n", newLine);
-  fprintf(fp, "    [-C <rate>]     | --sampling-rate                     %sPacket capture sampling rate [default: 1 (no sampling)]\n", newLine);
-  fprintf(fp, "    [-D <name>      | --domain <name>]                    %sInternet domain name\n", newLine);
-
-  fprintf(fp, "    [-F <spec>      | --flow-spec <specs>]                %sFlow specs (see man page)\n", newLine);
-
-#ifndef WIN32
-  fprintf(fp, "    [-K             | --enable-debug]                     %sEnable debug mode\n", newLine);
-#ifdef MAKE_WITH_SYSLOG
-  fprintf(fp, "    [-L]                                                  %sDo logging via syslog\n", newLine);
-  fprintf(fp, "    [               | --use-syslog=<facility>]            %sDo logging via syslog, facility ('=' is REQUIRED)\n",
-	  newLine);
-#endif /* MAKE_WITH_SYSLOG */
-#endif
-
-  fprintf(fp, "    [-M             | --no-interface-merge]               %sDon't merge network interfaces (see man page)\n",
-	  newLine);
-#ifdef ENABLE_FC
-  fprintf(fp, "    [-N             | --wwn-map]                          %sMap file providing map of WWN to FCID/VSAN\n", newLine);
-#endif
-  fprintf(fp, "    [-O <path>      | --pcap-file-path <path>]            %sPath for log files in pcap format\n", newLine);
-  fprintf(fp, "    [-U <URL>       | --mapper <URL>]                     %sURL (mapper.pl) for displaying host location\n",
-	  newLine);
-
-  fprintf(fp, "    [-V             | --version]                          %sOutput version information and exit\n", newLine);
-  fprintf(fp, "    [-X <max num TCP sessions> ]                          %sMax num. TCP sessions ntop can handle (default %u)\n",
-	  newLine, myGlobals.runningPref.maxNumSessions);
-  fprintf(fp, "    [--live]                                              %sEnable ntop live mode\n", newLine);
-/*  Please keep long-only options alphabetically ordered */
-
-  fprintf(fp, "    [--disable-instantsessionpurge]                       %sDisable instant FIN session purge\n", newLine);
-  fprintf(fp, "    [--disable-mutexextrainfo]                            %sDisable extra mutex info\n", newLine);
-  fprintf(fp, "    [--disable-stopcap]                                   %sCapture packets even if there's no memory left\n", newLine);
-
-#ifdef ENABLE_FC
-  fprintf(fp, "    [--fc-only]                                           %sDisplay only Fibre Channel statistics\n", newLine);
-  fprintf(fp, "    [--no-fc]                                             %sDisable processing & Display of Fibre Channel\n", newLine);
-  fprintf(fp, "    [--no-invalid-lun]                                    %sDon't display Invalid LUN information\n", newLine);
-#endif
-
-  fprintf(fp, "    [--instance <name>]                                   %sSet log name for this ntop instance\n", newLine);
-  fprintf(fp, "    [--p3p-cp]                                            %sSet return value for p3p compact policy, header\n", newLine);
-  fprintf(fp, "    [--p3p-uri]                                           %sSet return value for p3p policyref header\n", newLine);
-  fprintf(fp, "    [--skip-version-check]                                %sSkip ntop version check\n", newLine);
-  fprintf(fp, "    [--known-subnets]                                     %sList of known subnets (separated by ,)\n", newLine);
-  fprintf(fp, "                                                          %sIf the argument starts with @ it is assumed it is a file path\n", newLine);
-  fprintf(fp, "                                                          %sE.g. 192.168.0.0/14=home,172.16.0.0/16=private\n", newLine);
-#ifdef ENABLE_EFFICIENCY
-  fprintf(fp, "    [--enable-efficiency]                                 %sCompute network traffic efficiency on ATM cells\n", newLine);
-#endif
-
- fprintf(fp, "\n"
-	 "NOTE\n"
-	 "    * You can configure further ntop options via the web\n"
-	 "      interface [Menu Admin -> Config].\n"
-	 "    * The command line options are not permanent, i.e. they\n"
-	 "      are not persistent across ntop initializations.\n"
-	 "\n");
-
-#ifdef WIN32
-  printAvailableInterfaces();
-#endif
-}
-
-/* *********************************** */
-
 static void verifyOptions (void){
 
 #ifdef HAVE_OPENSSL
diff --git a/plugin.c b/plugin.c
index a66c382..de5b475 100644
--- a/plugin.c
+++ b/plugin.c
@@ -20,6 +20,8 @@
 
 #include "ntop.h"
 
+char static_ntop;
+
 #ifdef MAKE_STATIC_PLUGIN
 extern PluginInfo* icmpPluginEntryFctn(void);
 extern PluginInfo* sflowPluginEntryFctn(void);
diff --git a/prefs.c b/prefs.c
index 40a2682..2d2a0ce 100644
--- a/prefs.c
+++ b/prefs.c
@@ -1479,3 +1479,150 @@ void initUserPrefs(UserPref *pref) {
 }
 
 /* *******************************/
+
+/*
+ * Hello World! This is ntop speaking...
+ */
+void welcome (FILE * fp) {
+  fprintf (fp, "Welcome to %s v.%s (%d bit)\n"
+	   "[Configured on %s, built on %s]\n",
+	   myGlobals.program_name, version, sizeof(long) == 8 ? 64 : 32,
+	   configureDate, buildDate);
+
+  fprintf (fp, "Copyright 1998-2010 by %s.\n", author);
+  fprintf (fp, "Get the freshest ntop from http://www.ntop.org/\n");
+}
+
+
+/*
+ * Wrong. Please try again accordingly to ....
+ */
+void usage(FILE * fp) {
+  char *newLine = "";
+
+#ifdef WIN32
+  newLine = "\n\t";
+#endif
+
+  welcome(fp);
+
+  fprintf(fp, "\nUsage: %s [OPTION]\n\n", myGlobals.program_name);
+  fprintf(fp, "Basic options:\n");
+  fprintf(fp, "    [-h             | --help]                             %sDisplay this help and exit\n", newLine);
+#ifndef WIN32
+  fprintf(fp, "    [-u <user>      | --user <user>]                      %sUserid/name to run ntop under (see man page)\n", newLine);
+#endif /* WIN32 */
+  fprintf(fp, "    [-t <number>    | --trace-level <number>]             %sTrace level [0-6]\n", newLine);
+  fprintf(fp, "    [-P <path>      | --db-file-path <path>]              %sPath for ntop internal database files\n", newLine);
+  fprintf(fp, "    [-Q <path>      | --spool-file-path <path>]           %sPath for ntop spool files\n", newLine);
+  fprintf(fp, "    [-w <port>      | --http-server <port>]               %sWeb server (http:) port (or address:port) to listen on\n", newLine);
+#ifdef HAVE_OPENSSL
+  fprintf(fp, "    [-W <port>      | --https-server <port>]              %sWeb server (https:) port (or address:port) to listen on\n", newLine);
+#endif
+
+
+  fprintf(fp, "\nAdvanced options:\n");
+  fprintf(fp, "    [-4             | --ipv4]                             %sUse IPv4 connections\n",newLine);
+  fprintf(fp, "    [-6             | --ipv6]                             %sUse IPv6 connections\n",newLine);
+  fprintf(fp, "    [-a <file>      | --access-log-file <file>]           %sFile for ntop web server access log\n", newLine);
+  fprintf(fp, "    [-b             | --disable-decoders]                 %sDisable protocol decoders\n", newLine);
+  fprintf(fp, "    [-c             | --sticky-hosts]                     %sIdle hosts are not purged from memory\n", newLine);
+
+#ifndef WIN32
+  fprintf(fp, "    [-d             | --daemon]                           %sRun ntop in daemon mode\n", newLine);
+#endif
+  fprintf(fp, "    [-e <number>    | --max-table-rows <number>]          %sMaximum number of table rows to report\n", newLine);
+  fprintf(fp, "    [-f <file>      | --traffic-dump-file <file>]         %sTraffic dump file (see tcpdump)\n", newLine);
+  fprintf(fp, "    [-g             | --track-local-hosts]                %sTrack only local hosts\n", newLine);
+
+
+#ifndef WIN32
+  fprintf(fp, "    [-i <name>      | --interface <name>]                 %sInterface name or names to monitor\n", newLine);
+#else
+  fprintf(fp, "    [-i <number>    | --interface <number|name>]          %sInterface index number (or name) to monitor\n", newLine);
+#endif
+  fprintf(fp, "    [-j             | --create-other-packets]             %sCreate file ntop-other-pkts.XXX.pcap file\n", newLine);
+  fprintf(fp, "    [-l <path>      | --pcap-log <path>]                  %sDump packets captured to a file (debug only!)\n", newLine);
+  fprintf(fp, "    [-m <addresses> | --local-subnets <addresses>]        %sLocal subnetwork(s) (see man page)\n", newLine);
+  fprintf(fp, "    [-n             | --numeric-ip-addresses]             %sNumeric IP addresses - no DNS resolution\n", newLine);
+  fprintf(fp, "    [-o             | --no-mac]                           %sntop will trust just IP addresses (no MACs)\n", newLine);
+  fprintf(fp, "    [-p <list>      | --protocols <list>]                 %sList of IP protocols to monitor (see man page)\n", newLine);
+  fprintf(fp, "    [-q             | --create-suspicious-packets]        %sCreate file ntop-suspicious-pkts.XXX.pcap file\n", newLine);
+  fprintf(fp, "    [-r <number>    | --refresh-time <number>]            %sRefresh time in seconds, default is %d\n",
+	  newLine, DEFAULT_NTOP_AUTOREFRESH_INTERVAL);
+  fprintf(fp, "    [-s             | --no-promiscuous]                   %sDisable promiscuous mode\n", newLine);
+
+
+  fprintf(fp, "    [-x <max num hash entries> ]                          %sMax num. hash entries ntop can handle (default %u)\n",
+	  newLine, myGlobals.runningPref.maxNumHashEntries);
+  fprintf(fp, "    [-z             | --disable-sessions]                 %sDisable TCP session tracking\n", newLine);
+  fprintf(fp, "    [-A]                                                  %sAsk admin user password and exit\n", newLine);
+  fprintf(fp, "    [               | --set-admin-password=<pass>]        %sSet password for the admin user to <pass>\n", newLine);
+  fprintf(fp, "    [               | --w3c]                              %sAdd extra headers to make better html\n", newLine);
+  fprintf(fp, "    [-B <filter>]   | --filter-expression                 %sPacket filter expression, like tcpdump (for all interfaces)\n", newLine);
+  fprintf(fp, "                                                          %sYou can also set per-interface filter: \n", newLine);
+  fprintf(fp, "                                                          %seth0=tcp,eth1=udp ....\n", newLine);
+  fprintf(fp, "    [-C <rate>]     | --sampling-rate                     %sPacket capture sampling rate [default: 1 (no sampling)]\n", newLine);
+  fprintf(fp, "    [-D <name>      | --domain <name>]                    %sInternet domain name\n", newLine);
+
+  fprintf(fp, "    [-F <spec>      | --flow-spec <specs>]                %sFlow specs (see man page)\n", newLine);
+
+#ifndef WIN32
+  fprintf(fp, "    [-K             | --enable-debug]                     %sEnable debug mode\n", newLine);
+#ifdef MAKE_WITH_SYSLOG
+  fprintf(fp, "    [-L]                                                  %sDo logging via syslog\n", newLine);
+  fprintf(fp, "    [               | --use-syslog=<facility>]            %sDo logging via syslog, facility ('=' is REQUIRED)\n",
+	  newLine);
+#endif /* MAKE_WITH_SYSLOG */
+#endif
+
+  fprintf(fp, "    [-M             | --no-interface-merge]               %sDon't merge network interfaces (see man page)\n",
+	  newLine);
+#ifdef ENABLE_FC
+  fprintf(fp, "    [-N             | --wwn-map]                          %sMap file providing map of WWN to FCID/VSAN\n", newLine);
+#endif
+  fprintf(fp, "    [-O <path>      | --pcap-file-path <path>]            %sPath for log files in pcap format\n", newLine);
+  fprintf(fp, "    [-U <URL>       | --mapper <URL>]                     %sURL (mapper.pl) for displaying host location\n",
+	  newLine);
+
+  fprintf(fp, "    [-V             | --version]                          %sOutput version information and exit\n", newLine);
+  fprintf(fp, "    [-X <max num TCP sessions> ]                          %sMax num. TCP sessions ntop can handle (default %u)\n",
+	  newLine, myGlobals.runningPref.maxNumSessions);
+  fprintf(fp, "    [--live]                                              %sEnable ntop live mode\n", newLine);
+/*  Please keep long-only options alphabetically ordered */
+
+  fprintf(fp, "    [--disable-instantsessionpurge]                       %sDisable instant FIN session purge\n", newLine);
+  fprintf(fp, "    [--disable-mutexextrainfo]                            %sDisable extra mutex info\n", newLine);
+  fprintf(fp, "    [--disable-stopcap]                                   %sCapture packets even if there's no memory left\n", newLine);
+
+#ifdef ENABLE_FC
+  fprintf(fp, "    [--fc-only]                                           %sDisplay only Fibre Channel statistics\n", newLine);
+  fprintf(fp, "    [--no-fc]                                             %sDisable processing & Display of Fibre Channel\n", newLine);
+  fprintf(fp, "    [--no-invalid-lun]                                    %sDon't display Invalid LUN information\n", newLine);
+#endif
+
+  fprintf(fp, "    [--instance <name>]                                   %sSet log name for this ntop instance\n", newLine);
+  fprintf(fp, "    [--p3p-cp]                                            %sSet return value for p3p compact policy, header\n", newLine);
+  fprintf(fp, "    [--p3p-uri]                                           %sSet return value for p3p policyref header\n", newLine);
+  fprintf(fp, "    [--skip-version-check]                                %sSkip ntop version check\n", newLine);
+  fprintf(fp, "    [--known-subnets]                                     %sList of known subnets (separated by ,)\n", newLine);
+  fprintf(fp, "                                                          %sIf the argument starts with @ it is assumed it is a file path\n", newLine);
+  fprintf(fp, "                                                          %sE.g. 192.168.0.0/14=home,172.16.0.0/16=private\n", newLine);
+#ifdef ENABLE_EFFICIENCY
+  fprintf(fp, "    [--enable-efficiency]                                 %sCompute network traffic efficiency on ATM cells\n", newLine);
+#endif
+
+ fprintf(fp, "\n"
+	 "NOTE\n"
+	 "    * You can configure further ntop options via the web\n"
+	 "      interface [Menu Admin -> Config].\n"
+	 "    * The command line options are not permanent, i.e. they\n"
+	 "      are not persistent across ntop initializations.\n"
+	 "\n");
+
+#ifdef WIN32
+  printAvailableInterfaces();
+#endif
+}
+
+/* *********************************** */
diff --git a/Makefile.am b/Makefile.am
index 46b102c..33198c7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -115,7 +115,7 @@ bin_PROGRAMS   = ntop
 EXTRA_PROGRAMS = ntops
 bin_SCRIPTS    = 
 
-ntop_SOURCES       = main.c admin.c
+ntop_SOURCES       = main.c
 ntop_DEPENDENCIES  = libntopreport.la libntop.la
 ntop_LDADD         = libntopreport.la libntop.la $(BASE_LIBS)
 ntop_LDFLAGS       = $(AM_LDFLAGS)
@@ -134,7 +134,7 @@ libntop_la_SOURCES = address.c    argv.c        dataFormat.c   fcUtils.c \
                      plugin.c     prefs.c       protocols.c   \
                      sessions.c   term.c        util.c        utildl.c \
                      traffic.c    vendor.c      version.c      \
-                     ntop_darwin.c
+                     ntop_darwin.c admin.c
 
 libntop_la_DEPENDENCIES =  config.h
 libntop_la_LIBADD       = $(BASE_LIBS)
