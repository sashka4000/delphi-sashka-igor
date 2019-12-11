Source: haspdinst.exe; DestDir: {app}\Ext; Flags: uninsneveruninstall ignoreversion 32bit; Components: client
Source: drivers\h323_ex.psm; DestDir: {app}\Scada\drivers; Components: client; Flags:   ignoreversion 32bit
Source: help\*; DestDir: {app}\Help; Components: server client; Flags: ignoreversion 32bit
Source: extensions\bootstrap-4\css\*.*; DestDir: {app}\SCADA\extensions\bootstrap-4\css; Components: client; Flags:   ignoreversion 32bit
;Source: s:\distributive_2_3_x\extensions\basic_module.fx; DestDir: {app}\SCADA\extensions; Components: client; Flags:   ignoreversion 32bit
Source: !_shared\vcredist_x86.exe; DestDir: {app}\Ext; Components: client server; Flags: uninsneveruninstall ignoreversion 32bit
Source: modules\videovlc.psm; DestDir: {app}\SCADA\modules; Components: client; Flags:   ignoreversion 32bit