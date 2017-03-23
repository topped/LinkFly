-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 04, 2016 at 04:54 AM
-- Server version: 5.6.24
-- PHP Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `linkfly`
--

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE IF NOT EXISTS `announcements` (
  `announcements_id` int(11) NOT NULL,
  `announcements_message` text NOT NULL,
  `announcements_type` int(11) NOT NULL COMMENT '0 = info, 1 = warning, 2 = error, 3 = success',
  `announcements_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `announcements`
--

INSERT INTO `announcements` (`announcements_id`, `announcements_message`, `announcements_type`, `announcements_added`) VALUES
(1, 'Change this announcement in the admin panel', 0, '2016-02-04 03:42:27');

-- --------------------------------------------------------

--
-- Table structure for table `campaigns`
--

CREATE TABLE IF NOT EXISTS `campaigns` (
  `campaigns_id` int(11) NOT NULL,
  `campaigns_members_id` int(11) NOT NULL,
  `campaigns_name` varchar(255) NOT NULL,
  `campaigns_website_name` varchar(255) NOT NULL,
  `campaigns_website_url` varchar(255) NOT NULL,
  `campaigns_daily_budget` decimal(10,5) NOT NULL,
  `campaigns_current_budget` decimal(10,5) NOT NULL,
  `campaigns_budget_used_today` decimal(10,5) NOT NULL,
  `campaigns_last_budget_reset` datetime NOT NULL,
  `campaigns_started` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `campaigns_rates_id` int(11) NOT NULL,
  `campaigns_approved` tinyint(1) NOT NULL DEFAULT '0',
  `campaigns_reject_reason` text NOT NULL,
  `campaigns_ordered_views` int(11) NOT NULL COMMENT 'multiply by a thousand',
  `campaigns_status` tinyint(1) NOT NULL COMMENT '0 = running, 1 = stopped, 2 = ended',
  `campaigns_type` int(11) NOT NULL,
  `campaigns_device` int(11) NOT NULL COMMENT '0 = both, 1 = desktop, 2 = mobile',
  `campaigns_payment_accepted` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE IF NOT EXISTS `contacts` (
  `contacts_id` int(11) NOT NULL,
  `contacts_members_id` int(11) NOT NULL,
  `contacts_email` varchar(255) NOT NULL,
  `contacts_desc` text NOT NULL,
  `contacts_url` varchar(255) NOT NULL,
  `contacts_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `domains`
--

CREATE TABLE IF NOT EXISTS `domains` (
  `domains_id` int(11) NOT NULL,
  `domains_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `links`
--

CREATE TABLE IF NOT EXISTS `links` (
  `links_id` int(11) NOT NULL,
  `links_short` varchar(55) NOT NULL,
  `links_suffix` varchar(55) NOT NULL,
  `links_long_url` varchar(255) NOT NULL,
  `links_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `links_members_id` int(11) NOT NULL,
  `links_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `links_ad_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 = inter. 1 = banner 2 = none',
  `links_ip` varchar(255) NOT NULL,
  `links_profit` decimal(10,5) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE IF NOT EXISTS `members` (
  `members_id` bigint(20) NOT NULL,
  `members_username` varchar(255) NOT NULL,
  `members_email` varchar(75) NOT NULL,
  `members_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 = not activated, 1 = activated, 2 = banned',
  `members_admin` tinyint(1) NOT NULL DEFAULT '0',
  `members_password` varchar(255) NOT NULL,
  `members_balance` decimal(15,5) NOT NULL,
  `members_permissions_id` int(11) NOT NULL,
  `members_ip` varchar(255) NOT NULL,
  `members_email_code` varchar(255) NOT NULL,
  `members_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `members_password_change` timestamp NULL DEFAULT NULL,
  `members_activation_code` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`members_id`, `members_username`, `members_email`, `members_status`, `members_admin`, `members_password`, `members_balance`, `members_permissions_id`, `members_ip`, `members_email_code`, `members_added`, `members_password_change`, `members_activation_code`) VALUES
(1, 'admin', 'admin@yourwebsite.com', 1, 1, '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', '0.00000', 3, '', '', '2016-01-04 06:00:00', '2016-01-01 06:00:00', '');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE IF NOT EXISTS `pages` (
  `pages_id` int(11) NOT NULL,
  `pages_title` varchar(255) NOT NULL,
  `pages_slug` varchar(255) NOT NULL,
  `pages_lang` varchar(25) NOT NULL,
  `pages_content` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`pages_id`, `pages_title`, `pages_slug`, `pages_lang`, `pages_content`) VALUES
(16, 'About', 'about', 'english', 'Welcome to {$setting_site_name}!\r\nThis site allows you to easily shorten links and earn money while you''re at it!\r\n<br/><br/>\r\n<em>This page needs editing. As an admin, go to the admin panel, find ''Pages'', and edit this section.</em>'),
(17, 'Start Advertising', 'start-advertising', 'english', 'Welcome to {$setting_site_name}!\r\n<br/><br/>\r\n<em>This page needs editing. As an admin, go to the admin panel, find ''Pages'', and edit this section.</em>'),
(18, 'Get Paid', 'get-paid', 'english', 'Welcome to {$setting_site_name}!\r\n<br/><br/>\r\n<em>This page needs editing. As an admin, go to the admin panel, find ''Pages'', and edit this section.</em>'),
(19, 'Terms', 'terms', 'english', '<h3>General Rules <small>These apply to all links and general usage:</small></h3>\r\n<em>Breaking ANY of these rules will lead to the removal of your account!</em>\r\n<ul>\r\n<li>Do not advertise {$setting_site_name} links directly on any form of traffic exchange services.</li>\r\n<li>Do not place {$setting_site_name} links anywhere that may contain adult material (including advertising) or represent illegal content.</li>\r\n<li>Do not shorten any website URLs that contain adult material or illegal content.</li>\r\n<li>Do not offer any rewards for a visitor to click the {$setting_site_name} link, e.g. gifts, points, money.</li>\r\n<li>Do not beg people to click on an {$setting_site_name} link to generate you revenue.</li>\r\n<li>Do not create redirect loops with similar services (or {$setting_site_name}) to generate revenue or boost view count.</li>\r\n<li>Do not create spam with {$setting_site_name} links anywhere, including forums/chat/comments/blogs/social networks.</li>\r\n<li>Do not open an {$setting_site_name} link in a popup/popunder or iframe, it can only be a {$setting_site_name} link.</li>\r\n<li>It is permitted to automatically redirect to an {$setting_site_name} link only with a HTTP Redirect (unless using one of our preapproved scripts, available on the {$setting_site_name} website). JavaScript redirect or meta-refresh are not allowed.</li>\r\n<li>The only legitimate way to open an {$setting_site_name} link is with a mouse click, on the actual link. Bots do not count.</li>\r\n<li>The usage of bots or scripts to boost view count and generate revenue is illegal.</li>\r\n<li>We reserve the right to not pay for advert views generated by the owner of the {$setting_site_name} account, on their own links.</li>\r\n</ul>\r\n<h3>Advertiser Rules <small>If your ads contain the following, they will get removed and banned:</small></h3>\r\n<ul>\r\n<li>Pop-ups, adware, malware, script injectors</li>\r\n<li>Cookie Manipulation</li>\r\n<li>Autoplaying sounds or videos</li>\r\n<li>Any form of script or application that breaks the {$setting_site_name} frame</li>\r\n<li>Anything related to illegal products or services</li>\r\n<li>Explicit pornographic content</li>\r\n<li>Any form of ad that tries to trick or ''lure'' visitors using dishonest mean (i.e. faking a download button with no context)</li>\r\n</ul>'),
(20, 'Withdrawal Requests', 'withdrawals', 'english', '<strong>Why was my request denied?</strong><br/>\r\nYour withdrawal request could have been denied for the following reasons:\r\n<ul>\r\n<li>You are suspected of manipulating and artificially inflating view counts using bots, hacking, or other illicit means.</li>\r\n<li>Your link and/or the content redirected to violates the Terms of Service.</li>\r\n</ul>\r\n<strong>I believe my request was falsely denied. Can I still receive my money?</strong><br/>\r\n<p>No, we reserve the right to withhold any funds. However, you can contact support if you believe you deserve your funds.</p>'),
(21, 'Advertising Rates', 'advertising-rates', 'english', 'Our Advertising Rates are fair & make sense!\r\n<table class="table table-bordered table-striped" style="margin-top:15px;">\r\n<tr>\r\n<th>Name</th>\r\n<th>Description</th>\r\n<th>CPM </th>\r\n</tr>\r\n{foreach $rates as $rate}\r\n<tr>\r\n<td>{$rate[''rates_name'']}</td>\r\n<td>{$rate[''rates_desc'']}</td>\r\n<td>{format_price value=$rate[''rates_cpm'']}</td>\r\n</tr>\r\n{/foreach}\r\n</table>');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE IF NOT EXISTS `permissions` (
  `permissions_id` int(11) NOT NULL,
  `permissions_name` varchar(255) NOT NULL,
  `permissions_need_account` tinyint(1) NOT NULL DEFAULT '0',
  `permissions_can_shorten` tinyint(1) NOT NULL DEFAULT '1',
  `permissions_link_waiting_time_sec` int(11) NOT NULL DEFAULT '5',
  `permissions_need_captcha` tinyint(1) NOT NULL DEFAULT '0',
  `permissions_custom_alias` tinyint(1) NOT NULL DEFAULT '1',
  `permissions_change_domain` tinyint(1) NOT NULL DEFAULT '1',
  `permissions_change_ad_type` tinyint(1) NOT NULL DEFAULT '0',
  `permissions_can_advertise` tinyint(1) NOT NULL DEFAULT '1',
  `permissions_spam_waiting_time` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`permissions_id`, `permissions_name`, `permissions_need_account`, `permissions_can_shorten`, `permissions_link_waiting_time_sec`, `permissions_need_captcha`, `permissions_custom_alias`, `permissions_change_domain`, `permissions_change_ad_type`, `permissions_can_advertise`, `permissions_spam_waiting_time`) VALUES
(1, 'Anonymous', 0, 1, 10, 1, 1, 0, 0, 0, 10),
(2, 'Member', 1, 1, 10, 0, 1, 1, 1, 1, 5),
(3, 'Administrator', 1, 1, 0, 0, 1, 1, 1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `rates`
--

CREATE TABLE IF NOT EXISTS `rates` (
  `rates_id` int(11) NOT NULL,
  `rates_name` varchar(255) NOT NULL,
  `rates_desc` varchar(255) NOT NULL,
  `rates_cpm` decimal(10,2) NOT NULL,
  `rates_location` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rates`
--

INSERT INTO `rates` (`rates_id`, `rates_name`, `rates_desc`, `rates_cpm`, `rates_location`) VALUES
(1, 'Anywhere', '', '1.00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE IF NOT EXISTS `reports` (
  `reports_id` int(11) NOT NULL,
  `reports_topic` tinyint(1) NOT NULL,
  `reports_url` varchar(255) NOT NULL,
  `reports_email` varchar(255) NOT NULL,
  `reports_desc` text NOT NULL,
  `reports_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `settings_values`
--

CREATE TABLE IF NOT EXISTS `settings_values` (
  `settings_id` bigint(20) NOT NULL,
  `settings_name` varchar(255) NOT NULL,
  `settings_slug` varchar(255) NOT NULL,
  `settings_value` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_values`
--

INSERT INTO `settings_values` (`settings_id`, `settings_name`, `settings_slug`, `settings_value`) VALUES
(16, 'Site Name', 'site_name', 'LinkFly PHP'),
(17, 'Meta Desc', 'meta_desc', 'Shorten links and earn money.'),
(18, 'Meta Keywords', 'meta_keywords', 'link,url,short,shortener,quick,fast,buck,money,earn,make,advertiser,interstital,ads'),
(19, 'Meta Author', 'meta_author', '(c) 2016 LinkFly'),
(20, 'Site Language', 'site_lang', 'english'),
(21, 'Analytics Code', 'analytics_code', ''),
(22, 'Enable Branding', 'enable_branding', '1'),
(23, 'Copyright Footer', 'footer_copyright', '&copy; LinkFly PHP 2016'),
(24, 'Header Separator', 'header_separator', '|'),
(28, 'Default Permission for free accounts', 'default_permission_user', '2'),
(29, 'Logo URL', 'logo_url', 'templates/%s/img/logo.png'),
(30, 'Default Permission for visitors', 'default_permission_visitor', '1'),
(31, 'Logo URL Alternative', 'logo_url_alt', 'templates/%s/img/logo-alt.png'),
(32, 'Shortened suffix length', 'suffix_length', '6'),
(34, 'Interstitial Ad Percentage', 'interstitial_ad_percentage', '80'),
(35, 'Banner Ad Percentage', 'banner_ad_percentage', '70'),
(36, 'No Ad Percentage', 'no_ad_percentage', '0'),
(38, 'Site Currency', 'site_curr', 'USD'),
(39, 'Base URL', 'base_url', 'http://localhost/linkfly/'),
(40, 'Campaigns Need To Be Approved', 'campaigns_need_approval', '1'),
(42, 'Disallowed Domains', 'disallowed_domains', 'adf.ly,bit.ly,q.gs,j.gs,localhost,127.0.0.1,t.co'),
(43, 'Chart Fill Color', 'graph_fill_color', '#2CA3EA'),
(44, 'Chart Stroke Color', 'graph_stroke_color', '#2e8bcc'),
(45, 'Minimum Password Length', 'min_pass_length', '6'),
(46, 'Minimum Withdraw Amount', 'min_withdraw', '5.00000'),
(47, 'Show Language Picker', 'show_language_picker', '1'),
(49, 'Activate PayPal', 'payment_allow_paypal', '1'),
(52, 'Minimum Daily Budget', 'min_daily_budget', '2.00000'),
(53, 'Enable Ads', 'enable_ads', '0'),
(54, 'Minimum Quantity Views (Thousands)', 'min_quantity_views', '1'),
(55, 'Max Quantity Views (Thousands)', 'max_quantity_views', '10'),
(57, 'PayPal E-Mail', 'paypal_email', ''),
(60, 'Minimum Account Age Withdrawal (days)', 'min_account_age', '7'),
(61, 'Minimum Time Password Changed (Days)', 'min_pass_change_time', '1'),
(63, 'Update Requires Approval', 'update_requires_approval', '1'),
(64, 'Banner Width', 'banner_width', '800'),
(65, 'Banner Height', 'banner_height', '600'),
(66, 'Ad Home', 'ad_home', '<div class="ad">\r\n<img src="https://placeholdit.imgix.net/~text?txtsize=33&txt=Ad - Home&w=729&h=90" />\r\n</div>'),
(67, 'Ad Publisher', 'ad_publisher', '<div class="ad">\r\n<img src="https://placeholdit.imgix.net/~text?txtsize=33&txt=Ad - Publisher&w=729&h=90" />\r\n</div>'),
(68, 'Ad Advertiser', 'ad_advertiser', '<div class="ad">\r\n<img src="https://placeholdit.imgix.net/~text?txtsize=33&txt=Ad - Advertiser&w=729&h=90" />\r\n</div>'),
(69, 'Ad Statistics', 'ad_stats', '<div class="ad">\r\n<img src="https://placeholdit.imgix.net/~text?txtsize=33&txt=Ad - Statistics&w=729&h=90" />\r\n</div>'),
(70, 'Site Version', 'site_version', '1.0.0'),
(71, 'Payment Test Mode', 'payment_test_mode', '1'),
(73, 'Maintenance Mode', 'is_maintenance', '0'),
(74, 'Open Registration', 'open_registration', '1'),
(75, 'Template Name', 'template', 'default'),
(76, 'From E-Mail', 'email_from', 'test@localhost'),
(77, 'Currency Symbol', 'curr_symbol', '$'),
(78, 'Currency Symbol Position', 'curr_symbol_pos', '0'),
(79, 'Currency Code Pos', 'curr_code_pos', '2'),
(80, 'Enable Withdrawals', 'enable_withdrawals', '1'),
(81, 'Show Recent Announcement', 'show_recent_announcement', '1'),
(84, 'Custom Alias Min Length', 'custom_alias_min_length', '3'),
(85, 'Custom Alias Max Length', 'custom_alias_max_length', '15'),
(88, 'Anon Link Requires CAPTCHA', 'anon_link_captcha', '1'),
(89, 'Timezone', 'timezone', 'America/Chicago'),
(90, 'Disallow Proxies', 'disallow_proxies', '0');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE IF NOT EXISTS `transactions` (
  `transactions_id` int(11) NOT NULL,
  `transactions_object_type` int(11) NOT NULL COMMENT '1 = new campaign, 2 = extended campaign, etc...',
  `transactions_object_id` int(11) NOT NULL COMMENT 'ID of the object',
  `transactions_gateway` tinyint(2) NOT NULL COMMENT '0 = paypal, 1 = 2checkout',
  `transactions_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `transactions_value` decimal(10,5) NOT NULL,
  `transactions_curr` varchar(6) NOT NULL,
  `transactions_item_name` varchar(255) NOT NULL,
  `transactions_status` tinyint(2) NOT NULL,
  `transactions_members_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transactions_id`, `transactions_object_type`, `transactions_object_id`, `transactions_gateway`, `transactions_added`, `transactions_value`, `transactions_curr`, `transactions_item_name`, `transactions_status`, `transactions_members_id`) VALUES
(1, 1, 1, 0, '2016-02-01 00:58:49', '5.00000', 'USD', 'Campaign ''Scriptastic Ad #1'' 5k Views', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `views`
--

CREATE TABLE IF NOT EXISTS `views` (
  `views_id` int(11) NOT NULL,
  `views_link_id` int(11) NOT NULL,
  `views_ip` varchar(255) NOT NULL,
  `views_date` date NOT NULL,
  `views_campaign_id` int(11) NOT NULL,
  `views_country` varchar(55) NOT NULL,
  `views_referral` varchar(255) NOT NULL,
  `views_mobile_device` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0 = unknown, 1 = desktop, 2 = mobile'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `withdrawal_requests`
--

CREATE TABLE IF NOT EXISTS `withdrawal_requests` (
  `withdrawal_requests_id` int(11) NOT NULL,
  `withdrawal_requests_member_id` int(11) NOT NULL,
  `withdrawal_requests_amount` decimal(10,5) NOT NULL,
  `withdrawal_requests_curr` varchar(6) NOT NULL,
  `withdrawal_requests_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `withdrawal_requests_status` tinyint(1) NOT NULL COMMENT '0 = processing, 1 = processed, 2 = delay, 3 = failed, 4 = denied',
  `withdrawal_requests_pp_email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`announcements_id`);

--
-- Indexes for table `campaigns`
--
ALTER TABLE `campaigns`
  ADD PRIMARY KEY (`campaigns_id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`contacts_id`);

--
-- Indexes for table `domains`
--
ALTER TABLE `domains`
  ADD PRIMARY KEY (`domains_id`);

--
-- Indexes for table `links`
--
ALTER TABLE `links`
  ADD PRIMARY KEY (`links_id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`members_id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`pages_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`permissions_id`);

--
-- Indexes for table `rates`
--
ALTER TABLE `rates`
  ADD PRIMARY KEY (`rates_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`reports_id`);

--
-- Indexes for table `settings_values`
--
ALTER TABLE `settings_values`
  ADD PRIMARY KEY (`settings_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transactions_id`);

--
-- Indexes for table `views`
--
ALTER TABLE `views`
  ADD PRIMARY KEY (`views_id`);

--
-- Indexes for table `withdrawal_requests`
--
ALTER TABLE `withdrawal_requests`
  ADD PRIMARY KEY (`withdrawal_requests_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `announcements_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `campaigns`
--
ALTER TABLE `campaigns`
  MODIFY `campaigns_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `contacts_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `domains`
--
ALTER TABLE `domains`
  MODIFY `domains_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `links`
--
ALTER TABLE `links`
  MODIFY `links_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `members_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `pages_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `permissions_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `rates`
--
ALTER TABLE `rates`
  MODIFY `rates_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `reports_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `settings_values`
--
ALTER TABLE `settings_values`
  MODIFY `settings_id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=91;
--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transactions_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `views`
--
ALTER TABLE `views`
  MODIFY `views_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `withdrawal_requests`
--
ALTER TABLE `withdrawal_requests`
  MODIFY `withdrawal_requests_id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


INSERT INTO `linkfly`.`settings_values` (`settings_id`, `settings_name`, `settings_slug`, `settings_value`) VALUES (NULL, 'Enable Referrals', 'enable_referrals', '1');
INSERT INTO `linkfly`.`settings_values` (`settings_id`, `settings_name`, `settings_slug`, `settings_value`) VALUES (NULL, 'Default Campaign', 'default_campaign', '0');
INSERT INTO `linkfly`.`settings_values` (`settings_id`, `settings_name`, `settings_slug`, `settings_value`) VALUES (NULL, 'Enable API', 'enable_api', '1');
INSERT INTO `linkfly`.`settings_values` (`settings_id`, `settings_name`, `settings_slug`, `settings_value`) VALUES (NULL, 'Blocked IPs', 'blocked_ips', '');
INSERT INTO `linkfly`.`settings_values` (`settings_id`, `settings_name`, `settings_slug`, `settings_value`) VALUES (NULL, 'Ad View Link', 'ad_view_link', '<img src="https://placeholdit.imgix.net/~text?txtsize=33&txt=Ad - View Link&w=729&h=30" />');
ALTER TABLE `links` CHANGE `links_long_url` `links_long_url` VARCHAR(999) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL;
ALTER TABLE `members` ADD `members_api_key` VARCHAR(255) NOT NULL ;
UPDATE `linkfly`.`settings_values` SET `settings_value` = '1.1.0' WHERE `settings_values`.`settings_id` = 70;