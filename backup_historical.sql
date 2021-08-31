CREATE TABLE `ovms_historicalmessages_backup` (
  `owner` int(10) unsigned NOT NULL DEFAULT '0',
  `vehicleid` varchar(32) NOT NULL DEFAULT '' COMMENT 'Unique vehicle ID',
  `h_timestamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `h_recordtype` varchar(32) NOT NULL DEFAULT '',
  `h_recordnumber` int(5) NOT NULL DEFAULT '0',
  `h_data` text NOT NULL,
  `h_expires` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`owner`,`vehicleid`,`h_recordtype`,`h_recordnumber`,`h_timestamp`),
  KEY `h_expires` (`h_expires`),
  KEY `h_recordtype` (`h_recordtype`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='OVMS: Stores historical data records without deletion';

CREATE TRIGGER ovms_historicalmessages_dupe
AFTER INSERT ON ovms_historicalmessages
FOR EACH ROW
  INSERT INTO ovms_historicalmessages_backup (`owner`, `vehicleid`, `h_timestamp`, `h_recordtype`, `h_recordnumber`, `h_data`, `h_expires`)
  VALUES (NEW.owner, NEW.vehicleid, NEW.h_timestamp, NEW.h_recordtype, NEW.h_recordnumber, NEW.h_data, NEW.h_expires);
