<?php

//# Have a look in defaults.inc.php for examples of settings you can set here. DO NOT EDIT defaults.inc.php!
//Performance
$config['poller_modules']['ospf'] = false;

//## Database config
$config['db_host'] = 'localhost';
$config['db_port'] = '3306';
$config['db_user'] = 'Buralar HEP Dutluktu...';
$config['db_pass'] = 'Buralar HEP Dutluktu...';
$config['db_name'] = 'Buralar HEP Dutluktu...';
$config['db_socket'] = '';
$config['php_memory_limit'] = 16000;
$config['poller_modules']['mib'] = true;
$config['poller_modules']['stp'] = true;
$config['snmptraps']['eventlog'] = 'unhandled';
$config['permission.device_group.allow_dynamic'] = 1; #User'a Device Group ekleyebilmek için

$config['fping'] = "/usr/bin/fping";
$config['fping_options']['timeout'] = 500;
$config['fping_options']['count']   = 5;
$config['fping_options']['interval'] = 500;
$config['icmp_check'] = false;

//## RRDCACHED IpDegistir.
$config[‘rrdcached’] = '10.255.255.254:42217';
$config[‘rrd_dir’] = '/opt/pharus/rrd';
$config['rrdtool_version'] = '1.7.2';
//## Service User
$config['user'] = 'pharus';

//## Locations - it is recommended to keep the default
$config['install_dir'] = '/opt/pharus';
$config['rrdcached'] = 'unix:/var/run/rrdcached.sock';

$config['ping_rrd_step'] = 60;
$config['allow_unauth_graphs_cidr'] = ['127.0.0.1/32'];
$config['allow_unauth_graphs'] = true;
//## $config['allow_duplicate_sysName'] = true;

//## $config['public_status']    = true;
$config['network_map_items'] = ['mac', 'xdp'];
$config['network_map_vis_options'] = '{
  "nodes": {
    "borderWidth": null,
    "borderWidthSelected": null,
    "opacity": null,
    "size": null
  },
  "edges": {
    "arrows": {
      "to": {
        "enabled": true
      }
    },
    "color": {
      "opacity": 0.35
    },
    "selfReferenceSize": null,
    "selfReference": {
      "angle": 0.7853981633974483
    },
    "shadow": {
      "enabled": true
    },
    "smooth": {
      "forceDirection": "none"
    }
  },
  "layout": {
    "hierarchical": {
      "enabled": true
    }
  },
  "interaction": {
    "keyboard": {
      "enabled": true
    },
    "multiselect": true,
    "navigationButtons": true
  },
  "manipulation": {
    "enabled": true,
    "initiallyActive": true
  },
  "physics": {
    "hierarchicalRepulsion": {
      "centralGravity": 0,
      "avoidOverlap": null
    },
    "minVelocity": 0.75,
    "solver": "hierarchicalRepulsion"
  }
}';
//Nagios
$config['show_services'] = 1;
$config['nagios_plugins'] = '/nagios-plugins';

//## This should *only* be set if you want to *force* a particular hostname/port
//## It will prevent the web interface being usable form any other hostname
//NGINXDEN AL
$config['base_url'] = 'https://pharus.arya-it.com';
$config['site_style'] = 'light';

$config['force_hostname_to_sysname'] = false;
//## Enable this to use rrdcached. Be sure rrd_dir is within the rrdcached dir
//## and that your web server has permission to talk to rrdcached.

//## Default community
//$config['snmp']['community'] = array("public");
//$config['snmp']['community'] = array("ARYAsnmp2@!8");

//$config['snmp']['v3'][0]['authlevel'] = "AuthPriv";  # noAuthNoPriv | authNoPriv | authPriv
//$config['snmp']['v3'][0]['authname'] = "arya.snmp";           # User Name (required even for noAuthNoPriv)
//$config['snmp']['v3'][0]['authpass'] = "ARYAsnmp7854!";               # Auth Passphrase
//$config['snmp']['v3'][0]['authalgo'] = "SHA";            # MD5 | SHA
//$config['snmp']['v3'][0]['cryptopass'] = "ARYAsnmp7854!";             # Privacy (Encryption) Passphrase
//$config['snmp']['v3'][0]['cryptoalgo'] = "AES";          # AES | DES

//## Authentication Model
$config['auth_mechanism'] = 'mysql'; // default, other options: ldap, http-auth

//## List of RFC1918 networks to allow scanning-based discovery
$config['nets'][] = '10.0.0.0/8';
$config['nets'][] = '172.16.0.0/12';
$config['nets'][] = '192.168.0.0/16';
$config['discovery_by_ip'] = true;

// Update configuration
$config['update_channel'] = 'release';  // uncomment to follow the monthly release channel
//$config['update'] = 0;  # uncomment to completely disable updates

// Oxizeld
$config['oxidized']['enabled'] = true;
// Ifconfig Don
$config['oxidized']['url'] = 'http://10.255.255.254:8888';
$config['oxidized']['group_support'] = true;
$config['oxidized']['default_group'] = 'default';
$config['oxidized']['reload_nodes'] = true;

// Oxizeld Group
// $config['oxidized']['maps']['group']['hostname'][] = ['match' => '10.255.0.1', 'group' => 'MakdosFW'];
$config['oxidized']['maps']['group']['hostname'][] = ['regex' => '/10.255.0./', 'group' => 'Makdos'];

//Ignore
$config['oxidized']['ignore_types'] = ['server', 'power'];
$config['oxidized']['ignore_os'] = ['linux', 'windows'];
$config['oxidized']['ignore_model'] = ['drac'];

// Demiroz
$config['debug']['run_trace'] = true;
$config['traceroute'] = '/usr/bin/traceroute';
$config['traceroute6'] = '/usr/bin/traceroute6';

$config['title_image'] = 'images/custom/pharus_logo_menu.png';
//Billing
$config['enable_billing'] = 1; // Enable Billing
$config['billing_data_purge'] = 12;     // Number of months to retain
// Service
$config['show_locations'] = 1;  // Enable Locations on menu
$config['show_locations_dropdown'] = 1;  // Enable Locations dropdown on menu
$config['show_services'] = 1;  // Enable Services on menu
$config['int_customers'] = 1;  // Enable Customer Port Parsing
$config['summary_errors'] = 1;  // Show Errored ports in summary boxes on the dashboard
$config['customers_descr'] = 'cust'; // The description to look for in ifDescr. Can be an array as well array('cust','cid');
$config['transit_descr'] = 'transit'; // Add custom transit descriptions (can be an array)
$config['peering_descr'] = 'peering'; // Add custom peering descriptions (can be an array)
$config['core_descr'] = 'core'; // Add custom core descriptions (can be an array)
$config['custom_descr'] = ''; // Add custom interface descriptions (can be an array)
$config['int_transit'] = 1;  // Enable Transit Types
$config['int_peering'] = 1;  // Enable Peering Types
$config['int_core'] = 1;  // Enable Core Port Types
$config['int_l2tp'] = 1;  // Enable L2TP Port Types
$config['web_mouseover'] = true;
$config['enable_lazy_load'] = true;
$config['show_overview_tab'] = true;
$config['force_ip_to_sysname'] = true;
$config['discovery_modules']['arp-table'] = true;
$config['show_overview_tab'] = true;
$config['overview_show_sysDescr'] = true;
$config['enable_bgp'] = 1; // Enable BGP session collection and display
$config['enable_syslog'] = 1; // Enable Syslog
$config['enable_syslog_hooks'] = 1;
$config['enable_inventory'] = 1; // Enable Inventory
$config['enable_pseudowires'] = 1; // Enable Pseudowires
$config['enable_vrfs'] = 1; // Enable VRFs
$config['enable_sla'] = 1; // Enable Cisco SLA collection and display
$config['autodiscovery']['xdp'] = true;
$config['device_location_map_open'] = false;
$config['enable_ports_poe'] = true;
$config['os']['linux']['poller_modules']['stp'] = false;
$config['enable_libvirt'] = 1;
$config['libvirt_protocols'] = ['qemu+ssh', 'xen+ssh'];
$config['libvirt_username'] = 'root';

$config['syslog_purge'] = 1;
//$config['eventlog_purge']                                 = 30;
//$config['authlog_purge']                                  = 30;
//$config['perf_times_purge']                               = 30;
//$config['device_perf_purge']                              = 7;
$config['alert_log_purge'] = 365;
//$config['port_fdb_purge']                                 = 10;
//$config['rrd_purge']                                      = 90;
//$config['ports_purge'] = true;

//Email
$config['alert.transports.mail'] = true;
$config['email_from'] = "PharusNMS Alert <bilgilendirme@pharusnms.com>";
$config['email_user'] = "PharusNMS";
$config['email_backend']              = 'smtp';
$config['email_smtp_host']            = 'smtp.yandex.com.tr';
$config['email_smtp_port']            = "465";
$config['email_smtp_timeout']         = "10";
$config['email_smtp_secure']          = "ssl";
$config['email_smtp_auth']            = "true";
$config['email_smtp_username']        = "Buralar HEP Dutluktu...";
$config['email_smtp_password']        = "Buralar HEP Dutluktu...";

//Ruijiee

$config['ipmi']['type'] = [];
$config['ipmi']['type'][] = 'lanplus';
$config['ipmi']['type'][] = 'lan';
$config['ipmi']['type'][] = 'imb';
$config['ipmi']['type'][] = 'open';
//InfluxDB
//$config['influxdb']['enable'] = true;
//$config['influxdb']['transport'] = 'http'; # Default, other options: https, udp
//$config['influxdb']['host'] = '127.0.0.1';
//$config['influxdb']['port'] = '8086';
//$config['influxdb']['db'] = 'pharus';
//$config['influxdb']['username'] = 'admin';
//$config['influxdb']['password'] = 'ARYAdb7854';
//$config['influxdb']['timeout'] = 0; # Optional
//$config['influxdb']['verifySSL'] = false; # Optional
//Storage
$config['os']['linux']['storage_perc_warn'] = 80;

//$config['smokeping']['dir'] = '/var/lib/smokeping'; // Ubuntu 16.04 and newer Location
//$config['smokeping']['dir'] = '/opt/smokeping/data';
//$config['smokeping']['pings'] = 20;    // should be equal to "pings" in your smokeping config
//$config['smokeping']['integration'] = true;
//$config['smokeping']['url'] = 'smokeping/';  // If you have a specific URL or path for smokeping
//Promethe
//$config['prometheus']['enable'] = true;
//$config['prometheus']['url'] = 'http://127.0.0.1:9091';
// Discovery Modes
$config['discovery_modules']['applications'] = true;
$config['discovery_modules']['applications'] = true;

// Poller Modes
$config['poller_modules']['applications'] = true;
$config['poller_modules']['aruba-controller'] = true;
$config['poller_modules']['bgp-peers'] = true;
$config['poller_modules']['unix-agent'] = true;

$config['poller_modules']['availability'] = true;
$config['poller_modules']['stp'] = true;
$config['poller_modules']['ntp'] = true;
$config['poller_modules']['services'] = true;
//Performance
$config['poller_modules']['ospf'] = false;
$config['enable_clear_discovery'] = 1;
$config['graph_colours']['greens']  = array(
    'B6D14B',
    '91B13C',
    '6D912D',
    '48721E',
    '24520F',
    '003300',
);
$config['graph_colours']['blues']   = array(
    'A0A0E5',
    '8080BD',
    '606096',
    '40406F',
    '202048',
    '000033',
);
$config['graphs']['mini']['normal'] = array(
    'day' => '24 Hours',
    'week' => 'One Week',
    'month' => 'One Month',
    'year' => 'One Year',
);
$config['graphs']['mini']['widescreen'] = array(
    'sixhour' => '6 Hours',
    'day' => '24 Hours',
    'twoday' => '48 Hours',
    'week' => 'One Week',
    'twoweek' => 'Two Weeks',
    'month' => 'One Month',
    'twomonth' => 'Two Months',
    'year' => 'One Year',
    'twoyear' => 'Two Years',
);