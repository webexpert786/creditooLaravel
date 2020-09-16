-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 16, 2020 at 07:26 AM
-- Server version: 5.7.31-0ubuntu0.18.04.1
-- PHP Version: 7.2.24-0ubuntu0.18.04.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wwwcreditoolco_crm_tool`
--

-- --------------------------------------------------------

--
-- Table structure for table `aims`
--

CREATE TABLE `aims` (
  `id` bigint(20) NOT NULL,
  `claim_id` bigint(20) NOT NULL,
  `blueSkyThinking` text NOT NULL,
  `practical` text NOT NULL,
  `difficulty` text NOT NULL,
  `newResearch` text NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `aims`
--

INSERT INTO `aims` (`id`, `claim_id`, `blueSkyThinking`, `practical`, `difficulty`, `newResearch`, `created_at`) VALUES
(1, 3, 'no', ', of which a fair amount was used to find a practical application.', 'The company had some materials related difficulties it had to overcome.', 'The company had some challenges in taking something that existed and making it better in a measurable way.', '2020-08-07 08:30:14'),
(2, 1, 'a fair amount of', ', of which a fair amount was used to find a practical application.', 'The company overcame quite a lot of difficulties relating to materials.', 'The company did loads of work by taking something that already existed and making it better in a measurable way.', '2020-08-07 11:39:44'),
(3, 9, 'a bit of', '.', 'The company had few materials related difficulties it had to overcome.', 'The company had few challenges in taking something that existed and making it better in a measurable way.', '2020-08-07 13:15:24'),
(4, 10, 'no', '.', 'The company had no material related difficulties to overcome.', 'There was nothing the company had to overcome in terms of taking something that existed to make it better in a measurable way.', '2020-08-10 04:55:45'),
(5, 14, 'a bit of', '.', 'The company had lots of material related difficulties that it needed to overcome.', 'The company had few challenges in taking something that existed and making it better in a measurable way.', '2020-08-10 09:27:50'),
(6, 15, 'a fair amount of', 'and quite a lot of the research was used to find a practical application.', 'The company had few materials related difficulties it had to overcome.', 'The company did loads of work by taking something that already existed and making it better in a measurable way.', '2020-09-09 09:55:09'),
(7, 16, 'a fair amount of', 'and lots of this was used to find a practical application.', 'The company had some materials related difficulties it had to overcome.', 'The company did loads of work by taking something that already existed and making it better in a measurable way.', '2020-09-09 10:00:53'),
(8, 17, 'a fair amount of', 'and quite a lot of the research was used to find a practical application.', 'The company overcame quite a lot of difficulties relating to materials.', 'The company did loads of work by taking something that already existed and making it better in a measurable way.', '2020-09-10 08:31:40'),
(9, 18, 'quite a lot', 'and lots of this was used to find a practical application.', 'The company had some materials related difficulties it had to overcome.', 'The company did lots of work by taking something that already existed and making it better in a measurable way.', '2020-09-14 08:58:54'),
(10, 19, 'a fair amount of', 'and quite a lot of the research was used to find a practical application.', 'The company overcame quite a lot of difficulties relating to materials.', 'The company did loads of work by taking something that already existed and making it better in a measurable way.', '2020-09-14 12:34:50');

-- --------------------------------------------------------

--
-- Table structure for table `case_notes`
--

CREATE TABLE `case_notes` (
  `case_id` bigint(20) UNSIGNED NOT NULL,
  `claim_id` int(20) NOT NULL,
  `case_notes` text COLLATE utf8_unicode_ci NOT NULL,
  `created_by` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `case_notes`
--

INSERT INTO `case_notes` (`case_id`, `claim_id`, `case_notes`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 'ZXZXCZXC', 'zxcZXcZx', '2020-08-06 14:16:22', NULL),
(2, 10, 'Rest', 'not', '2020-08-10 06:20:38', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `claims`
--

CREATE TABLE `claims` (
  `id` bigint(20) NOT NULL,
  `company_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(15) DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `paid_status` varchar(15) NOT NULL DEFAULT 'no',
  `company_basics` varchar(15) NOT NULL DEFAULT 'false',
  `about` varchar(15) NOT NULL DEFAULT 'false',
  `invite` varchar(15) NOT NULL DEFAULT 'false',
  `projects` varchar(15) NOT NULL DEFAULT 'false',
  `staffCosts` varchar(15) NOT NULL DEFAULT 'false',
  `epwCosts` varchar(15) NOT NULL DEFAULT 'false',
  `subcontractorCosts` varchar(15) NOT NULL DEFAULT 'false',
  `consumableCosts` varchar(15) NOT NULL DEFAULT 'false',
  `softwareCosts` varchar(15) NOT NULL DEFAULT 'false',
  `expenses` varchar(15) NOT NULL DEFAULT 'false',
  `commercialGoals` varchar(15) NOT NULL DEFAULT 'false',
  `aims` varchar(15) NOT NULL DEFAULT 'false',
  `difficulties` varchar(15) NOT NULL DEFAULT 'false',
  `technicalChallenges` varchar(15) NOT NULL DEFAULT 'false',
  `nonTechAreas` varchar(15) NOT NULL DEFAULT 'false',
  `declaration` varchar(15) NOT NULL DEFAULT 'false',
  `businessTerms` varchar(15) NOT NULL DEFAULT 'false',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `claims`
--

INSERT INTO `claims` (`id`, `company_id`, `status`, `endDate`, `paid_status`, `company_basics`, `about`, `invite`, `projects`, `staffCosts`, `epwCosts`, `subcontractorCosts`, `consumableCosts`, `softwareCosts`, `expenses`, `commercialGoals`, `aims`, `difficulties`, `technicalChallenges`, `nonTechAreas`, `declaration`, `businessTerms`, `created_at`, `updated_at`) VALUES
(1, 1, 'completed', '2020-06-04', 'no', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'false', '2020-08-07 13:49:41', '2020-08-07 13:49:41'),
(2, 1, 'in-progress', '2020-06-04', 'no', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'true', 'false', 'false', 'false', '2020-08-07 09:57:07', '2020-08-07 09:57:07'),
(3, 2, 'in-progress', '2020-06-04', 'no', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'false', 'false', 'false', 'false', '2020-08-07 09:24:59', '2020-08-07 09:24:59'),
(4, 3, 'in-progress', '2020-06-04', 'no', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', '2020-08-07 06:34:43', '0000-00-00 00:00:00'),
(5, 1, 'in-progress', '2020-06-04', 'no', 'true', 'true', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', '2020-08-07 12:01:52', '2020-08-07 12:01:52'),
(6, 1, 'in-progress', '2020-06-04', 'no', 'true', 'true', 'true', 'true', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', '2020-08-07 12:08:48', '2020-08-07 12:08:48'),
(7, 1, 'in-progress', '2020-06-04', 'no', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', '2020-08-07 11:35:04', '0000-00-00 00:00:00'),
(8, 1, 'in-progress', '2020-06-04', 'no', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', '2020-08-07 11:52:52', '0000-00-00 00:00:00'),
(9, 1, 'in-progress', '2020-06-04', 'no', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'false', 'false', 'false', 'false', 'false', '2020-08-07 13:16:34', '2020-08-07 13:16:34'),
(10, 1, 'completed', '2020-06-04', 'no', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'false', '2020-09-01 13:43:56', '2020-09-01 13:43:56'),
(11, 1, 'in-progress', '2020-06-04', 'no', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', '2020-08-07 12:16:24', '0000-00-00 00:00:00'),
(12, 1, 'in-progress', '2020-06-04', 'no', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', '2020-08-10 08:13:05', '2020-08-10 08:13:05'),
(13, 1, 'in-progress', '2020-06-04', 'no', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', '2020-08-10 08:12:59', '2020-08-10 08:12:59'),
(14, 1, 'completed', '2020-06-04', 'no', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'false', '2020-09-10 09:59:08', '2020-09-10 09:59:08'),
(15, 4, 'completed', '2020-06-04', 'no', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'false', '2020-09-09 10:59:34', '2020-09-09 10:59:34'),
(16, 4, 'completed', '2020-06-04', 'no', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'false', '2020-09-09 10:01:14', '2020-09-09 10:01:14'),
(17, 5, 'completed', '2020-06-04', 'no', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'false', '2020-09-15 11:53:16', '2020-09-15 11:53:16'),
(18, 6, 'in-progress', '2020-06-04', 'no', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'false', 'false', '2020-09-14 12:15:08', '2020-09-14 12:15:08'),
(19, 7, 'in-progress', '2020-06-04', 'no', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'false', 'false', '2020-09-14 12:44:36', '2020-09-14 12:44:36');

-- --------------------------------------------------------

--
-- Table structure for table `client_company`
--

CREATE TABLE `client_company` (
  `company_id` bigint(20) UNSIGNED NOT NULL,
  `added_by` bigint(20) NOT NULL,
  `company_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company_reg` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `directory_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `incorporated_date` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `client_company`
--

INSERT INTO `client_company` (`company_id`, `added_by`, `company_name`, `email`, `phone`, `company_reg`, `directory_name`, `incorporated_date`, `created_at`, `updated_at`) VALUES
(1, 70, 'ROAD LTD', 'hociho2897@ainbz.com', '+44 1234 56678', '05658633', 'testmnsme', '2005-12-20', '2020-08-06 02:15:37', '2020-09-10 09:58:47'),
(2, 70, 'tester.ltd', 'demo@yopmail.com', '+44 121234657', 'tester', 'test', '2020-08-06', '2020-08-07 05:48:50', '2020-08-07 09:24:11'),
(3, 70, 'tester.ltd', 'democoder@yopmail.com', '+91 98765 43210', 'tester', 'jyjytjyt', '2020-08-07', '2020-08-07 06:34:42', NULL),
(4, 71, 'PROMOTIONAL MAILING SERVICES GROUP LIMITED', 'Adrian.rothera@pmsg.co.uk', '+44 1732 783600', '00788950', 'Adrian Rothera', '1964-01-23', '2020-09-09 09:46:17', '2020-09-09 10:59:25'),
(5, 71, 'EPROTEK SERVICES LTD', 'Rab.eprotek@gmail.com', '+44 1506 238400', 'SC482291', 'Robert Walker', '2014-07-16', '2020-09-10 08:25:31', '2020-09-15 11:32:37'),
(6, 71, 'OAKFIRE ADVENTURES LTD', 'Info@oakfireadventures.com', '+44 800 121 6242', 'NI603765', 'Richard Allen', '2010-07-09', '2020-09-14 08:51:22', '2020-09-14 12:14:51'),
(7, 71, 'MAKE AGENCY LIMITED', 'Dan.w@makeagency.co.uk', '+44 20 3567 0860', '08834390', 'Thomas Witcherley', '2014-01-07', '2020-09-14 12:25:23', '2020-09-14 12:40:43');

-- --------------------------------------------------------

--
-- Table structure for table `cms`
--

CREATE TABLE `cms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `added_by` int(20) UNSIGNED NOT NULL,
  `cms_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cms_slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cms_meta_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cms_meta_keyword` mediumtext COLLATE utf8_unicode_ci,
  `cms_meta_description` text COLLATE utf8_unicode_ci,
  `cms_detail` text COLLATE utf8_unicode_ci NOT NULL,
  `cms_status` int(11) NOT NULL DEFAULT '0' COMMENT '0:disable,1:enable',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `cms`
--

INSERT INTO `cms` (`id`, `added_by`, `cms_title`, `cms_slug`, `cms_meta_title`, `cms_meta_keyword`, `cms_meta_description`, `cms_detail`, `cms_status`, `created_at`, `updated_at`) VALUES
(6, 5, 'Terms & Conditions', 'terms-condition', 'Terms & Conditions', 'terms,condition', 'Terms & Conditions', '<h1>Shephard &amp; Co Services Agreement with you, &#8220;the Customer&#8221;</h1><p>This&#10; agreement is between TGG Ltd, a company incorporated in England &#10;(Registered Number 10754811), and having its Registered Office at Unit &#10;8, Edward Court, Altrincham Business Park, WA14 5GL; trading as Shephard&#10; &amp; Co (&#8220;Shephard &amp; Co&#8221;) and you, (&#8220;the Customer&#8221;).</p><p>By accepting these Terms and Conditions, the Customer agrees to be bound by them.</p><p>If&#10; the Customer does not agree to be bound by these Terms and Conditions, &#10;the Customer cannot order or use any Subscription Services.</p><p>The Customer must be at least 18 years old to order Subscription Services.</p><p>Shephard&#10; &amp; Co&#8217; issue of an Order Form to the Customer constitutes a &#10;contractual offer and the Customer signing and returning a copy of an &#10;Order Form, or otherwise acceptance of an Order Form (whether in hard or&#10; soft copy or by the actions of the Customer), will conclude the &#10;contract between Shephard &amp; Co and the Customer relating to the &#10;Subscription Services listed in the Order Form.</p><p>The contract &#10;(&#8220;Agreement&#8221;) between the Customer and Shephard &amp; Co will comprise &#10;these terms and conditions, the signed Order Form and the Privacy Policy&#10; and (where appropriate) the SLA. If there is any conflict between the &#10;terms of the Order Form and these terms and conditions, then the terms &#10;of the Order Form will prevail.</p><h2>PART ONE &#8211; SUBSCRIPTION SERVICES.</h2><ol><li><strong>Access to the Subscription Services.</strong><p>Shephard&#10; &amp; Co grants to the Customer a non-exclusive, non-transferable &#10;(except as provided in Clause 20.4) licence to use the Subscription &#10;Services for the Customer&#8217;s internal business purposes only, subject to &#10;the following conditions:-</p><ol><li><p>The Subscription Services are &#10;located on the Platform. Shephard &amp; Co has full administrative &#10;access rights to the Platform. Users may access the Subscription &#10;Services, but have no right to administer the Platform or receive a copy&#10; of the object code or source code to the Software.</p></li><li><p>Users&#10; must have reasonable speed Internet connection, and provide its own &#10;Local Equipment that is compatible with the Subscription Services, as &#10;set out in the Documentation. None of these things are Shephard &amp; &#10;Co&#8217; responsibility.</p></li><li><p>Shephard &amp; Co may periodically &#10;Upgrade and Update the Services, in order to provide Users with a &#10;greater, evolving user experience. Some of these changes shall occur &#10;automatically, during scheduled maintenance or Update, while others may &#10;require the Customer to schedule and implement the changes. The changes &#10;may also mean that Users need to upgrade their Local Equipment in order &#10;to make efficient use of the Subscription Services. Shephard &amp; Co &#10;shall provide the Customer with reasonable notification in advance in &#10;this case.</p></li><li><p>Shephard &amp; Co has all required distribution rights to the intellectual property in the Software and the Documentation.</p></li><li><p>Shephard&#10; &amp; Co shall be under no liability to the Customer in respect of &#10;anything which, apart from this provision, may constitute breach of this&#10; Agreement arising by reason of Force Majeure.</p></li></ol></li><li><strong>Conditions of Use.</strong><p>The&#10; Subscription Services provided to the Customer are non-exclusive, &#10;non-transferable (except as provided in Clause 20.4), and are for the &#10;Customer&#8217;s internal business use only. The Customer&#8217;s right to use the &#10;Subscription Services is subject to the following conditions:-</p><p>the Customer shall not:</p><ol><li><p>Transfer to any other person any of its rights to use the Subscription Services;</p></li><li><p>Sell, license, rent or lease the Subscription Services;</p></li><li><p>Make the Subscription Services available to anyone who is not a User;</p></li><li><p>Create any derivative works based upon the Subscription Services or Documentation;</p></li><li><p>Copy&#10; any feature, design or graphic in, or reverse engineer the Software &#10;including, but without prejudice to the foregoing generality, copying &#10;the Graphical User Interface, icons, look and feel of the Software or &#10;Subscription Services, Menu Command Hierarchy, fonts or colour scheme;</p></li><li><p>Access&#10; the Subscription Services (i) in order to build a competitive solution &#10;or to assist someone else to build a competitive solution; or (ii) if &#10;the User is an employee or contractor of a Shephard &amp; Co competitor;</p></li><li><p>Use the Subscription Services in a way that violates any criminal or civil law;</p></li><li><p>Load test the Subscription Services in order to test scalability; or,</p></li><li><p>Exceed any usage limits listed the applicable Order Form.</p></li><li><p>Alter,&#10; re-use or duplicate any Report in order to create a style or template &#10;report or use any Report or altered, re-used or duplicated Report to &#10;create a report or similar document for the same End User or another End&#10; User or third party whose data was not used to create the original &#10;Report, in order to avoid paying fees.</p></li><li><p>Demonstrate any aspect of the Subscription Services to anyone associated in any way with a Shephard &amp; Co competitor.</p></li></ol></li><li><strong>User Content/Security.</strong><ol><li><p>The&#10; Customer provides all data for use in the Subscription Services, and &#10;Shephard &amp; Co is not obliged to modify or add to User Content except&#10; as specified in Clause 4. The Customer is solely responsible for User &#10;Content and the accuracy of User Content.</p></li><li><p>User Content belongs to the Customer or its licensors, and Shephard &amp; Co makes no claim to any right of ownership in it.</p></li><li><p>Shephard &amp; Co shall keep User Content confidential in accordance with Clause 16 of this Agreement.</p></li><li><p>Subject&#10; to the terms of Clause 4, Shephard &amp; Co shall only be entitled to &#10;use User Content strictly as necessary to carry out its obligations &#10;under this Agreement, and for no other purpose. However, Shephard &amp; &#10;Co:</p><ol><li><p>may observe and report back to the Customer on the &#10;Customer&#8217;s usage of the Subscription Services, and make recommendations &#10;for improved usage of the Subscription Services;</p></li><li><p>may &#10;identify trends and publish reports on its findings provided the reports&#10; include data aggregated from more than one Customer and do not identify&#10; the Customer; and,</p></li><li><p>shall use reasonable endeavours to ensure that the data centre containing the User Content complies with ISO 27001</p></li></ol></li><li><p>Shephard&#10; &amp; Co shall use reasonable endeavours to comply with the principles &#10;of the DPA and GDPR in accordance with the Privacy Policy. For the &#10;purposes of the GDPR, Shephard &amp; Co will be a Data Processor and the&#10; Customer will be the Data Controller of User Content.</p></li><li><p>Sharing&#10; of accounts is not permitted unless expressly authorised in writing by &#10;Shephard &amp; Co. Users must keep account details confidential and &#10;Users should not reveal their username or password to any unauthorised &#10;third parties. Furthermore, Industry Best Practice security &#10;recommendations should be implemented at all times, such as (a) &#10;maintaining a recognised Cyber Essentials Certification for IT systems &#10;such as https://www.cyberessentials.ncsc.gov.uk (b) Always implementing &#10;Strong, robust, difficult to break passwords, that are changed on a &#10;regular basis (c) that Users do not save account details in their &#10;internet browser (d) Implementing Two Factor authentication at each &#10;endpoint and (e) contract with a reputable IT support company to &#10;maintain Local Equipment, keeping it updated with the latest security &#10;patches at all times. Shephard &amp; Co accepts no liability for any &#10;losses or damages incurred as a result of account details being shared &#10;or if Industry Best Practice is not observed in breach of the terms of &#10;this Agreement. Shephard &amp; Co accepts no liability for any losses or&#10; damages incurred as a result of account details being shared in breach &#10;of the terms of this Agreement.</p></li><li><p>Passwords must be robust and difficult to break and changed frequently.</p></li><li><p>It is recommended that Users do not save account details in their internet browser.</p></li></ol></li><li><strong>Acceptable Usage Policy.</strong><ol><li><p>Without&#10; prejudice to the generality of Clause 2.7, when using the Subscription &#10;Services; Users should do so in accordance with the following rules:</p></li><li><p>Users must not use obscene or vulgar language;</p></li><li><p>User&#10; Sites may not contain any material that is unlawful or otherwise &#10;objectionable (including that which may be in breach of rules, &#10;regulations or legislation in force in the United Kingdom or any other &#10;jurisdiction in which your User Site can be lawfully accessed. This does&#10; not extend to material which may be automatically blocked in certain &#10;jurisdictions but that is lawful in your home country);</p></li><li><p>Your&#10; User Site may not contain any material that is intended to promote or &#10;incite violence or any other unlawful conduct against any group, &#10;individual or animal. This includes, but is not limited to, the &#10;provision of instructions on how to assemble weapons of any kind, bombs,&#10; grenades or other explosive devices;</p></li><li><p>User Sites may not &#10;infringe the intellectual property rights of any third party including, &#10;but not limited to, copyright, trademarks, patents and designs;</p></li><li><p>User&#10; Sites may not contain any material that may contain viruses or other &#10;software or instructions that may damage or disrupt other software, &#10;computer hardware or communications networks;</p></li><li><p>User Sites may not be used for unauthorised mass-communications such as &#8220;spam&#8221; or &#8220;junk mail&#8221;; and</p></li><li><p>Shephard&#10; &amp; Co does not screen or pre-approve any User Site or User Content &#10;(although Users acknowledge that Shephard &amp; Co may do so if it &#10;wishes).</p></li><li><p>Shephard &amp; Co may edit a User Site to comply&#10; with the provisions of sub-Clause 4.1 without prior consultation. In &#10;cases of severe breaches of the provisions of sub-Clause 4.1, a User &#10;Site may be taken down and the relevant account may be suspended or &#10;terminated. The Customer will not be informed in writing of the reasons &#10;for such alterations or take downs.</p></li><li><p>Shephard &amp; Co accepts no responsibility or liability for any infringement of third party rights by User Sites.</p></li><li><p>Shephard&#10; &amp; Co will not be liable in any way or under any circumstances for &#10;any loss or damage that any User may incur as a result of such User &#10;Sites, or Shephard &amp; Co exercising its rights under this Agreement, &#10;nor for any errors or omissions in User Sites. Use of and reliance upon &#10;User Sites is entirely at your own risk.</p></li><li><p>The Customer &#10;acknowledges that Shephard &amp; Co may retain copies of any and all &#10;communications, information, User Content and User Sites sent to &#10;Shephard &amp; Co.</p></li><li><p>Users must comply with the terms of &#10;the DPA and the GDPR at all times. Without prejudice to the foregoing, &#10;The Customer hereby warrants, represents, and undertakes that User &#10;Content comprising Personal Data shall comply with the GDPR in all &#10;respects including, but not limited to, its collection, holding, and &#10;processing.</p></li></ol></li><li><strong>Intellectual Property.</strong><ol><li><p>Subject&#10; to the exceptions in Clause 6 of this Agreement, all Content, that is &#10;not User Content, and the Database and the Software are the property of &#10;Shephard &amp; Co, or Shephard &amp; Co&#8217; Affiliates or licensors. By &#10;continuing to use the Subscription Services you acknowledge that such &#10;material is protected by applicable United Kingdom and international &#10;intellectual property and other laws.</p></li><li><p>You may print, &#10;reproduce, copy, distribute, store or in any other fashion re-use &#10;Content from the Subscription Services for personal or educational &#10;purposes only unless otherwise given Shephard &amp; Co&#8217; express written &#10;permission to do so. Specifically, the Customer agrees that it will not &#10;systematically copy Content from the Subscription Services with a view &#10;to creating or compiling any form of comprehensive collection, &#10;compilation, directory or database unless given Shephard &amp; Co&#8217; &#10;express written permission to do so.</p></li></ol></li><li><strong>User Site Intellectual Property</strong><ol><li><p>The&#10; intellectual property rights subsisting in the User Content of User &#10;Sites belong to the User to which that/those User Site(s) belong(s) &#10;unless it is expressly stated otherwise.</p></li><li><p>Where expressly &#10;indicated, certain Content available through User Sites and the &#10;intellectual property rights subsisting therein belongs to other &#10;parties.</p></li><li><p>The third party Content described in this Clause&#10; 6, unless expressly stated to be so, is not covered by any permission &#10;granted by Clause 5 of these Terms and Conditions to use Content.</p></li><li><p>For the avoidance of doubt, the Database (excluding the User Content therein) shall not be considered User Content.</p></li></ol></li><li><strong>Third Party Intellectual Property.</strong><ol><li><p>Unless&#10; otherwise expressly indicated, all Intellectual Property rights &#10;including, but not limited to, Copyright and Trademarks, in Content &#10;belong to the manufacturers or distributors of such products as may be &#10;applicable.</p></li><li><p>Subject to Clause 5 you may not reproduce, &#10;copy, distribute, store or in any other fashion re-use Content unless &#10;otherwise indicated on the Website and/or the Services or unless given &#10;express written permission to do so by the relevant manufacturer or &#10;supplier.</p></li></ol></li><li><strong>Subscription Services Warranties.</strong><p>Shephard&#10; &amp; Co warrants that: (i) the Subscription Services will function &#10;substantially as described in the Documentation; and (ii) Shephard &amp;&#10; Co owns or otherwise has the right to provide the Subscription Services&#10; to the Customer under this Agreement. The remedies set out in this &#10;Clause 8 are the Customer&#8217;s exclusive remedies for breach of either &#10;warranty.</p><ol><li><p>If the Subscription Services do not function &#10;substantially in accordance with the Documentation, Shephard &amp; Co &#10;shall, at its option, either (i) modify the Subscription Services to &#10;conform to the Documentation; or (ii) provide a workaround solution that&#10; will reasonably meet the Customer&#8217;s requirements. If neither of these &#10;options is commercially feasible, either party may terminate the &#10;relevant Order Form under this Agreement, in which case Shephard &amp; &#10;Co shall refund to the Customer all fees pre-paid to Shephard &amp; Co &#10;under the relevant Order Form for unused Subscription Services.</p></li><li><p>If&#10; the normal operation, possession or use of the Subscription Services by&#10; the Customer is found to infringe any third party intellectual property&#10; right or Shephard &amp; Co believes that this is likely, Shephard &amp;&#10; Co shall, at its option, either (i) obtain a license from such third &#10;party for the benefit of the Customer; (ii) modify the Subscription &#10;Services so that they no longer infringe; or (iii) if neither of these &#10;options is commercially feasible, terminate the relevant Order Form &#10;under this Agreement, in which case Shephard &amp; Co shall refund to &#10;the Customer all fees pre-paid to Shephard &amp; Co under the relevant &#10;Order Form for unused Subscription Services.</p></li><li><p>However, Shephard &amp; Co has no warranty obligations for:</p><ol><li><p>the&#10; extent that Software has been modified by the Customer or any third &#10;party, unless the modification has been approved in writing by Shephard &#10;&amp; Co;</p></li><li><p>problems in the Subscription Services caused by&#10; any third party software or hardware, by accidental damage or by other &#10;matters beyond Shephard &amp; Co&#8217; reasonable control.</p></li></ol></li><li><p>Where&#10; a User enters fraudulent or inaccurate information, should HMRC open an&#10; enquiry into a Claim, it is the End User&#8217;s responsibility to defend &#10;and/or substantiate that Claim. It is the Customer&#8217;s duty to inform End &#10;Users of this stipulation. The Customer will indemnify Shephard &amp; Co&#10; against any action taken against Shephard &amp; Co by an End User in &#10;relation to an End User&#8217;s reliance on any Report or output from the &#10;Subscription Services.</p></li><li><p>HMRC may challenge and refuse &#10;Claims. Shephard &amp; Co cannot guarantee that a Claim prepared using &#10;the Subscription Services will be successful.</p></li><li><p>The &#10;Software permits End Users to state which kind of evidence they have to &#10;support their Claim. If an End User states it has the relevant evidence,&#10; it is the End User&#8217;s responsibility to present it, should it ever be &#10;requested by HMRC. It is the Customer&#8217;s duty to inform the End User of &#10;this proviso.</p></li><li><p>Shephard &amp; Co will not defend enquiries&#10; related to an End User&#8217;s Claim. Shephard &amp; Co provides the &#10;Subscription Services to the Customer and has no relationship with or &#10;duty of care or otherwise to the End User. The indemnity in Clause 8.3.3&#10; shall apply.</p></li><li><p>Please note that the Software&#8217;s default &#10;assumption is that an End User is an SME unless the factors/criteria set&#10; out in the Software indicate otherwise; however whereas the criteria &#10;are designed to give a high degree of accuracy, the criteria are not &#10;exhaustive and infallible. The outputs of the Software rely on accurate &#10;and truthful responses to the criteria/questions in the Software.</p></li></ol></li><li><strong>PART TWO &#8211; PROFESSIONAL SERVICES.</strong></li><li><strong>Professional Services Warranties.</strong><p>Shephard&#10; &amp; Co warrants that (i) the Professional Services shall &#10;substantially conform to the applicable Order Form; and (ii) the &#10;Professional Services shall be performed with reasonable skill, care and&#10; diligence. The remedies set out in this Clause 9 are the Customer&#8217;s &#10;exclusive remedies for breach of either warranty. If the Professional &#10;Services do not conform to the Order Form or are not performed with &#10;reasonable skill, care and diligence, Shephard &amp; Co shall re-perform&#10; the Professional Services to the extent necessary to correct the &#10;defective performance.</p></li><li><strong>The Customer&#8217;s Responsibilities.</strong><p>The&#10; Customer shall provide Shephard &amp; Co with all information, access, &#10;and full good faith cooperation reasonably necessary to enable Shephard &#10;&amp; Co to deliver the Professional Services, and shall do anything &#10;that is identified in the Order Form as the Customer&#8217;s responsibility. &#10;If the Customer fails to do this, Shephard &amp; Co shall be relieved of&#10; its obligations to the extent that the obligations are dependent upon &#10;the Customer&#8217;s performance.</p></li><li><strong>PART THREE &#8211; GENERAL.</strong></li><li><strong>Term of Agreement.</strong><p>This&#10; Agreement starts on the date that the Customer accepts an Order Form &#10;and ends when Shephard &amp; Co no longer is obliged to provide the &#10;Customer with Subscription Services or Professional Services under any &#10;Order Form.</p></li><li><strong>Payments.</strong><ol><li><p>The Customer shall pay the fees listed in, and in accordance with, the relevant Order Form.</p></li><li><p>If&#10; the Customer initially purchases Subscription Services for a term, and &#10;subsequently orders an additional product, the purchase price for the &#10;additional product shall be pro-rated so that the added subscriptions &#10;terminate on the same day as the initial subscription.</p></li></ol></li><li><strong>Termination and Suspension.</strong><ol><li><p>The&#10; Customer may terminate rights granted to a license subscription under a&#10; particular Order Form only after expiry of the initial term specified &#10;in the Order Form. Such notice must be given in writing not less than 30&#10; days prior to the date of expiry of the said initial term (time being &#10;of the essence) otherwise the subscription will continue for the same &#10;term as specified in the Order Form at the Fee specified in the Order &#10;Form. Termination applies to the Shephard &amp; Co subscription Software&#10; licencing element only and does not include any service elements &#10;contained on the Order Form. Service elements include but are not &#10;limited to data conversion and/or on-site training or project management&#10; that are itemised separately on the Order Form. Service elements will &#10;only be terminated when a settlement of 100% of these service costs have&#10; been recovered by Shephard &amp; Co.</p></li><li><p>Either party may &#10;terminate rights granted under a particular Order Form if the other &#10;breaches any material term of the Order Form (including a material term &#10;of this Agreement insofar as it applies to the Order Form) and the &#10;breach is not cured within 30 days of written notice. The Customer&#8217;s &#10;breach of Clause 2.9 of this Agreement shall be considered a material &#10;breach.</p></li><li><p>Instead of terminating rights granted to the &#10;Customer under an Order Form, Shephard &amp; Co may suspend the &#10;provision of Subscription Services to the Customer for a period of up to&#10; 45 days. At any time during that period, Shephard &amp; Co may &#10;terminate the rights granted to the Customer.</p></li><li><p>Clauses 2, 3.3, 4,5,6,7, 8, 9, 12, 14, 15, 16, 17 and 18 continue after this Agreement ends.</p></li><li><p>If&#10; Shephard &amp; Co terminates an Order Form under this Agreement because&#10; of non-payment by the Customer, all unpaid fees for the remainder of &#10;the Subscription Term immediately fall due for payment.</p></li><li><p>Upon&#10; termination of this Agreement (except in the case of termination due to&#10; the Customer&#8217;s material breach of this Agreement), the Customer will be&#10; given restricted access for a period of ten days in which to recover &#10;their User Content. Shephard &amp; Co can provide a Customer Content &#10;recovery service to the Customer, should they wish to use it. Shephard &#10;&amp; Co reserves the right to charge for this service.</p></li><li><p>Shephard&#10; &amp; Co may retain User Content in backup media for an additional &#10;period of up to 12 months after the date of termination of this &#10;Agreement, or longer if required by law.</p></li><li><p>Termination also&#10; covers the eventuality of data migration for any other reason including&#10; ceasing to offer the services or changing suppliers.</p></li></ol></li><li><strong>Warranty Disclaimer.</strong><p>EXCEPT&#10; AS EXPRESSLY PROVIDED IN THIS AGREEMENT, THE SUBSCRIPTION SERVICES, &#10;SOFTWARE AND PROFESSIONAL SERVICES ARE PROVIDED WITH NO OTHER WARRANTIES&#10; OF ANY KIND, AND SHEPHARD &amp; CO DISCLAIMS ALL OTHER WARRANTIES, &#10;EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION ANY WARRANTY OF &#10;MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. SHEPHARD &amp; CO &#10;DOES NOT WARRANT THAT THE USE OF THE SUBSCRIPTION SERVICES SHALL BE &#10;UNINTERRUPTED OR ERROR-FREE.</p></li><li><strong>Limitation of Liability.</strong><p>NEITHER&#10; PARTY SHALL BE LIABLE UNDER THIS AGREEMENT FOR ANY INDIRECT, SPECIAL, &#10;INCIDENTAL, PUNITIVE OR CONSEQUENTIAL DAMAGES (INCLUDING WITHOUT &#10;LIMITATION DAMAGES FOR LOSS OF GOODWILL, WORK STOPPAGE, COMPUTER FAILURE&#10; OR MALFUNCTION, LOST OR CORRUPTED DATA, LOST PROFITS, LOST BUSINESS OR &#10;LOST OPPORTUNITY), OR ANY OTHER SIMILAR DAMAGES UNDER ANY THEORY OF &#10;LIABILITY (WHETHER IN CONTRACT, TORT/DELICT, STRICT LIABILITY OR ANY &#10;OTHER THEORY), EVEN IF THE OTHER PARTY HAS BEEN INFORMED OF THIS &#10;POSSIBILITY. THE CUSTOMER ASSUMES ALL RESPONSIBILITY FOR THE SELECTION &#10;OF THE SUBSCRIPTION SERVICES, SOFTWARE AND DOCUMENTATION NECESSARY TO &#10;ACHIEVE THE CUSTOMER&#8217;S INTENDED RESULTS, AND FOR THE USE AND RESULTS OF &#10;THE SUBSCRIPTION SERVICES. EACH PARTY&#8217;S TOTAL LIABILITY FOR ANY DIRECT &#10;LOSS, COST, CLAIM OR DAMAGES OF ANY KIND RELATED TO THE RELEVANT ORDER &#10;FORM SHALL NOT EXCEED THE AMOUNT OF THE FEES PAID OR PAYABLE BY THE &#10;CUSTOMER TO SHEPHARD &amp; CO UNDER SUCH RELEVANT ORDER FORM DURING THE &#10;PERIOD OF 12 MONTHS BEFORE THE EVENT GIVING RISE TO SUCH LOSS, COST, &#10;CLAIM OR DAMAGES. THIS LIMITATION ON LIABILITY WAS AND IS AN EXPRESS &#10;PART OF THE CONTRACT BETWEEN SHEPHARD &amp; CO AND THE CUSTOMER AND WAS A&#10; CONTROLLING FACTOR IN THE SETTING OF THE FEES PAYABLE TO SHEPHARD &amp;&#10; CO. HOWEVER, THERE IS NO LIMITATION ON DIRECT LOSS, CLAIM OR DAMAGES &#10;ARISING AS A RESULT OF AN INFRINGEMENT OF SHEPHARD &amp; CO&#8217;S &#10;INTELLECTUAL PROPERTY RIGHTS BY THE CUSTOMER, OR A BREACH OF CLAUSE 16 &#10;OF THIS AGREEMENT BY THE CUSTOMER, OR IN CONNECTION THE CUSTOMER&#8217;S &#10;INDEMNIFICATION OBLIGATIONS.</p><p>SHEPHARD &amp; CO&#8217; LIABILITY UNDER &#10;THIS AGREEMENT (EXCEPT WHERE PROVIDED OTHERWISE IN THIS AGREEMENT TO A &#10;LESSER EXTENT) SHALL BE LIMITED TO THE AMOUNT OF PROFESSIONAL INDEMNITY &#10;INSURANCE UNDERWRITTEN IN THE NAME OF SHEPHARD &amp; CO WHICH SHALL BE &#10;&#163;1,000,000.</p></li><li><strong>Confidentiality</strong><ol><li><p>The &#10;Subscription Services, Software, Documentation and Order Form contain &#10;valuable trade secrets that are the sole property of Shephard &amp; Co, &#10;and the Customer agrees to use reasonable care to prevent third parties &#10;from learning of these trade secrets. The Customer shall take reasonable&#10; care to prevent unauthorised access to or duplication of the &#10;Subscription Services, Software, Documentation, and Order Form. The &#10;Customer shall use reasonable endeavours to ensure that their employees,&#10; agents and independent contractors are bound by the same duty of &#10;confidentiality to Shephard &amp; Co in terms of this Clause 16.</p></li><li><p>The&#10; User Content may include valuable trade secrets that are the sole &#10;property of the Customer. Shephard &amp; Co shall take reasonable care &#10;to prevent third parties from learning of these trade secrets. Shephard &#10;&amp; Co use reasonable endeavours to ensure that their employees, &#10;agents and independent contractors are bound by the same duty of &#10;confidentiality to Shephard &amp; Co in terms of this Clause 16.</p></li><li><p>Clauses&#10; 16.1 and 16.2 do not apply to any information that (i) is now, or &#10;subsequently becomes, through no act or failure to act on the part of &#10;receiving party (the &#8220;Receiver&#8221;), generally known or available; (ii) is &#10;known by the Receiver at the time of receiving such information, as &#10;evidenced by the Receiver&#8217;s records; (iii) is subsequently provided to &#10;the Receiver by a third party, as a matter of right and without &#10;restriction on disclosure; or (iv) is required to be disclosed by law, &#10;provided that the party to whom the information belongs is given prior &#10;written notice of any such proposed disclosure.</p></li></ol></li><li><strong>Indemnification by Shephard &amp; Co.</strong><ol><li><p>Subject&#10; to the terms of Clause 15, Shephard &amp; Co shall indemnify and hold &#10;harmless the Customer, its Affiliates, directors and employees from any &#10;damages finally awarded against the Customer (including, without &#10;limitation, reasonable costs and legal fees incurred by the Customer) &#10;arising out of any third party suit, claim or other legal action &#10;alleging that the use of the Subscription Services or Documentation by &#10;the Customer (other than User Content &#8211; see Clauses 4 and 18) infringes &#10;any copyright, trade secret or United Kingdom patent, (&#8220;Legal Action&#8221;). &#10;Shephard &amp; Co shall provide reasonable assistance in the defence of &#10;such Legal Action.</p></li><li><p>However, Shephard &amp; Co shall have &#10;no indemnification obligations for any Legal Action arising out of: (i) a&#10; combination of the Subscription Services and/or Software with software &#10;or products not supplied, or approved in writing by Shephard &amp; Co; &#10;(ii) any repair, adjustment, modification or alteration to the &#10;Subscription Services by the Customer or any third party, unless &#10;approved in writing by Shephard &amp; Co; or (iii) any refusal by the &#10;Customer to install and use a non-infringing version of the Subscription&#10; Services offered by Shephard &amp; Co under Clause 8.2(ii). Clause &#10;8.2(ii) and this Clause 17 state the entire liability of Shephard &amp; &#10;Co with respect to any intellectual property infringement by the &#10;Subscription Services or Software or Documentation.</p></li><li><p>The &#10;Customer shall give written notice to Shephard &amp; Co of any Legal &#10;Action no later than 30 days after first receiving notice of a Legal &#10;Action, and shall give copies to Shephard &amp; Co of all &#10;communications, notices and/or other actions relating to the Legal &#10;Action. The Customer shall give Shephard &amp; Co the sole control of &#10;the defence of any Legal Action, shall act in accordance with the &#10;reasonable instructions of Shephard &amp; Co and shall give Shephard &#10;&amp; Co such assistance as Shephard &amp; Co reasonably requests to &#10;defend or settle such claim. Shephard &amp; Co shall conduct its defence&#10; at all times in a manner that is not adverse to the Customer&#8217;s &#10;interests. the Customer may employ its own counsel to assist it with &#10;respect to any such claim. The Customer shall bear all costs of engaging&#10; its own counsel, unless engagement of counsel is necessary because of a&#10; conflict of interest with Shephard &amp; Co or its counsel, or because &#10;Shephard &amp; Co fails to assume control of the defence. The Customer &#10;shall not settle or compromise any Legal Action without Shephard &amp; &#10;Co&#8217; express written consent. Shephard &amp; Co shall be relieved of its &#10;indemnification obligation under Clause 17 if the Customer materially &#10;fails to comply with Clause 17.2.</p></li></ol></li><li><strong>Indemnification by the Customer.</strong><ol><li><p>The&#10; Customer shall indemnify and hold harmless Shephard &amp; Co, its &#10;Affiliates, directors, and employees from any damages finally awarded &#10;against Shephard &amp; Co (including, without limitation, reasonable &#10;costs and legal fees incurred by Shephard &amp; Co) arising out of any &#10;third party suit (including those of End Users), claim or other legal &#10;action (including but not limited to any governmental investigations, &#10;complaints and actions) in connection with the User Content, including, &#10;without limitation, any action for infringement of any trademark, &#10;copyright, trade secret, right of publicity or privacy (including &#10;defamation), patent or other proprietary right with respect to the User &#10;Content (&#8220;Legal Claim&#8221;).</p></li><li><p>Shephard &amp; Co shall give &#10;written notice to the Customer of any Legal Claim no later than 30 days &#10;after first receiving notice of a Legal Claim, and shall give copies to &#10;the Customer of all communications, notices and/or other actions &#10;relating to the Legal Claim. Shephard &amp; Co shall give the Customer &#10;the sole control of the defence of any Legal Claim, shall act in &#10;accordance with the reasonable instructions of the Customer and shall &#10;give the Customer such assistance as the Customer reasonably requests to&#10; defend or settle such claim. the Customer shall conduct its defence at &#10;all times in a manner which is not adverse to Shephard &amp; Co&#8217; &#10;interests. Shephard &amp; Co may employ its own counsel to assist it &#10;with respect to any such claim. Shephard &amp; Co shall bear all costs &#10;of engaging its own counsel, unless engagement of counsel is necessary &#10;because of a conflict of interest with the Customer or its counsel, or &#10;because the Customer fails to assume control of the defence. Shephard &#10;&amp; Co shall not settle or compromise any Legal Claim without the &#10;Customer&#8217;s express written consent. the Customer shall be relieved of &#10;its indemnification obligation under Clause 18 if Shephard &amp; Co &#10;materially fails to comply with Clause 18.1.</p></li></ol></li><li><strong>Publicity.</strong><ol><li><p>Shephard&#10; &amp; Co may list the Customer as a customer and use the Customer&#8217;s &#10;logo on Shephard &amp; Co&#8217; website, on publicly available Customer &#10;lists, and in media releases with the Customer&#8217;s consent, such consent &#10;not to be unreasonably withheld</p></li></ol></li><li><strong>Miscellaneous.</strong><ol><li><p>This&#10; Agreement represents the entire agreement of the parties, and &#10;supersedes any prior or current agreements or understandings, whether &#10;written or oral. If there is a conflict between the Agreement and an &#10;Order Form, the Order Form shall prevail.</p></li><li><p>This Agreement may not be changed or any part waived except by written agreement between the parties.</p></li><li><p>This&#10; Agreement shall be governed by the laws of Scotland. The parties &#10;consent to the exercise of exclusive jurisdiction of the Scottish Courts&#10; for any claim relating to this Agreement.</p></li><li><p>The Customer &#10;shall not assign or otherwise transfer any of its rights or obligations &#10;under this Agreement without the prior written consent of Shephard &amp;&#10; Co. Shephard &amp; Co may not withhold such consent in the case of an &#10;assignment by the Customer of its rights and obligations to an entity &#10;that has acquired all, or substantially all of the Customer&#8217;s assets, or&#10; to an assignment that is part of a genuine corporate restructure. Any &#10;assignment in breach of this Clause is void.</p></li><li><p>We reserve &#10;the right to update, alter or amend these Terms and Conditions at any &#10;time. Any such updates, alterations or amendments will be notified to &#10;you in writing.</p></li></ol></li><li><strong>Data Processing.</strong><ol><li><p>The&#10; provisions of this Agreement shall apply to the processing of the &#10;Personal Data carried out for the Customer by Shephard &amp; Co, and to &#10;all Personal Data held by Shephard &amp; Co in relation to all such &#10;processing whether such Personal Data is held at the date of this &#10;Agreement or received afterwards.</p></li><li><p>This Agreement shall &#10;continue in full force and effect for so long as Shephard &amp; Co is &#10;processing Personal Data on behalf of the Customer.</p></li><li><p>Shephard &amp; Co is only to process the Personal Data received from the Customer:</p><ol><li><p>for the purposes of this Agreement and not for any other purpose;</p></li><li><p>to the extent and in such a manner as is necessary for those purposes; and</p></li><li><p>strictly&#10; in accordance with the Agreement or otherwise with the express written &#10;authorisation and instructions of the Customer (which may be specific &#10;instructions or instructions of a general nature or as otherwise &#10;notified by the Customer to Shephard &amp; Co).</p></li></ol></li><li><p>All&#10; instructions given by the Customer to Shephard &amp; Co shall be made &#10;in writing and shall at all times be in compliance with the GDPR and &#10;other applicable laws. Shephard &amp; Co shall act only on such written &#10;instructions from the Customer unless Shephard &amp; Co is required by &#10;law to do otherwise (as per Article 29 of the GDPR).</p></li><li><p>Both&#10; Parties shall comply at all times with the GDPR and other applicable &#10;laws and shall not perform their obligations under this Agreement or any&#10; other agreement or arrangement between themselves in such way as to &#10;cause either party to breach any of its applicable obligations under the&#10; GDPR.</p></li><li><p>The Customer hereby warrants, represents, and &#10;undertakes that the Personal Data shall comply with the GDPR in all &#10;respects including, but not limited to, its collection, holding, and &#10;processing.</p></li><li><p>Shephard &amp; Co agrees to comply with any &#10;reasonable measures required by the Customer to ensure that its &#10;obligations under this Agreement are satisfactorily performed in &#10;accordance with any and all applicable legislation from time to time in &#10;force (including, but not limited to, the GDPR) and any best practice &#10;guidance issued by the ICO.</p></li><li><p>Shephard &amp; Co shall &#10;provide all reasonable assistance (at the Customer&#8217;s cost) to the &#10;Customer in complying with its obligations under the GDPR with respect &#10;to the security of processing, the notification of personal data &#10;breaches, the conduct of data protection impact assessments, and in &#10;dealings with the ICO.</p></li><li><p>When processing the Personal Data on behalf of the Customer, Shephard &amp; Co shall:</p><ol><li><p>not&#10; process the Personal Data outside the European Economic Area (all EU &#10;member states, plus Iceland, Liechtenstein, and Norway) (&#8220;EEA&#8221;) without &#10;the prior written consent of the Customer and, where the Customer &#10;consents to such a transfer to a country that is outside of the EEA, to &#10;comply with the obligations of Data Processors under the provisions &#10;applicable to transfers of Personal Data to third countries set out in &#10;Chapter 5 of the GDPR by providing an adequate level of protection to &#10;any Personal Data that is transferred;</p></li><li><p>not transfer any &#10;of the Personal Data to any third party without the written consent of &#10;the Customer and, in the event of such consent, the Personal Data shall &#10;be transferred strictly subject to the terms of a suitable agreement, as&#10; set out in Clause 21.19;</p></li><li><p>process the Personal Data only &#10;to the extent, and in such manner, as is necessary in order to comply &#10;with its obligations to the Customer or as may be required by law (in &#10;which case, Shephard &amp; Co shall inform the Customer of the legal &#10;requirement in question before processing the Personal Data for that &#10;purpose unless prohibited from doing so by law);</p></li><li><p>implement&#10; appropriate technical and organisational measures, and take all steps &#10;necessary to protect the Personal Data against unauthorised or unlawful &#10;processing, accidental loss, destruction, damage, alteration, or &#10;disclosure;</p></li><li><p>make available to the Customer any and all &#10;such information as is reasonably required and necessary to demonstrate &#10;Shephard &amp; Co&#8217;s compliance with the GDPR; and</p></li><li><p>inform &#10;the Customer immediately if it is asked to do anything that infringes &#10;the GDPR or any other applicable data protection legislation.</p></li></ol></li><li><p>Shephard&#10; &amp; Co shall, at the Customer&#8217;s cost, assist the Customer in &#10;complying with its obligations under the GDPR. In particular, the &#10;following shall apply to data subject access requests, complaints, and &#10;data breaches:</p><ol><li><p>Shephard &amp; Co shall notify the Customer without undue delay if it receives:</p><ol><li><p>a subject access request from a data subject; or</p></li><li><p>any other complaint or request relating to the processing of the Personal Data.</p></li></ol></li></ol></li><li><p>Shephard&#10; &amp; Co shall, at the Customer&#8217;s cost, cooperate fully with the &#10;Customer and assist as required in relation to any subject access &#10;request, complaint, or other request, including by:</p><ol><li><p>providing the Customer with full details of the complaint or request;</p></li><li><p>providing the necessary information and assistance in order to comply with a subject access request;</p></li><li><p>providing&#10; the Customer with any Personal Data it holds in relation to a data &#10;subject (within the timescales required by the Customer); and</p></li><li><p>providing the Customer with any other information requested by the Customer.</p></li></ol></li><li><p>Shephard&#10; &amp; Co shall notify the Customer immediately if it becomes aware of &#10;any form of Personal Data breach, including any unauthorised or unlawful&#10; processing, loss of, damage to, or destruction of any of the Personal &#10;Data.</p></li><li><p>The Customer shall be liable for, and shall &#10;indemnify (and keep indemnified) Shephard &amp; Co in respect of any and&#10; all action, proceeding, liability, cost, claim, loss, expense &#10;(including reasonable legal fees and payments on a solicitor and client &#10;basis), or demand suffered or incurred by, awarded against, or agreed to&#10; be paid by, Shephard &amp; Co and any Sub-Processor arising directly or&#10; in connection with:</p><ol><li><p>any non-compliance by the Customer with the GDPR or other applicable legislation;</p></li><li><p>&gt;any&#10; Personal Data processing carried out by Shephard &amp; Co or &#10;Sub-Processor in accordance with instructions given by the Customer that&#10; infringe the GDPR or other applicable legislation; or</p></li><li><p>any&#10; breach by the Customer of its obligations under this Agreement, except &#10;to the extent that Shephard &amp; Co or Sub-Processor is liable under &#10;sub-Clause 21.16.</p></li></ol></li><li><p>Shephard &amp; Co shall be &#10;liable for, and shall indemnify (and keep indemnified) the Customer in &#10;respect of any and all action, proceeding, liability, cost, claim, loss,&#10; expense (including reasonable legal fees and payments on a solicitor &#10;and client basis), or demand suffered or incurred by, awarded against, &#10;or agreed to be paid by, the Customer arising directly or in connection &#10;with Shephard &amp; Co&#8217;s Personal Data processing activities that are &#10;subject to this Agreement:</p><ol><li><p>only to the extent that the same results from Shephard &amp; Co&#8217;s or a Sub-Processor&#8217;s breach of this Agreement; and</p></li><li><p>not to the extent that the same is or are contributed to by any breach of this Agreement by the Customer.</p></li></ol></li><li><p>The&#10; Customer shall not be entitled to claim back from Shephard &amp; Co or a&#10; Sub-Processor any sums paid in compensation by the Customer in respect &#10;of any damage to the extent that the Customer is liable to indemnify &#10;Shephard &amp; Co or Sub-Processor under sub-Clause 21.15.</p></li><li><p>Nothing&#10; in this Agreement (and in particular, this Clause 21) shall relieve &#10;either party of, or otherwise affect, the liability of either party to &#10;any data subject, or for any other breach of that party&#8217;s direct &#10;obligations under the GDPR. Furthermore, Shephard &amp; Co hereby &#10;acknowledges that it shall remain subject to the authority of the ICO &#10;and shall co-operate fully therewith, as required, and that failure to &#10;comply with its obligations as a data processor under the GDPR may &#10;render it subject to the fines, penalties, and compensation requirements&#10; set out in the GDPR.</p></li><li><p>In the event that Shephard &amp; Co appoints a Sub-Processor, Shephard &amp; Co shall:</p><ol><li><p>enter&#10; into a Sub-Processing Agreement with the Sub-Processor which shall &#10;impose upon the Sub-Processor the same or similar obligations as are &#10;imposed upon Shephard &amp; Co by this Agreement; and</p></li><li><p>ensure that the Sub-Processor complies fully with its obligations under the Sub-Processing Agreement and the GDPR.</p></li></ol></li></ol></li><li><strong>Service Levels and Support</strong><ol><li><p>If support is listed as a Professional Service on a relevant Order Form then the SLA will form part of the Agreement.</p></li></ol></li><li><strong>PART FOUR &#8211; DEFINITIONS.</strong></li><li><strong>Glossary</strong><ol><li><p><strong>&#8220;Affiliate&#8221;</strong>&#160;means&#10; an entity which controls, is controlled by, or is under common control &#10;with, a party, and control means the ability to vote 50% or more of the &#10;voting securities of any entity or otherwise having the ability to &#10;influence and direct the polices and direction of an entity;</p></li><li><p><strong>&#8220;Claim&#8221;</strong>&#160;means a claim for Research and Development Tax Credits;</p></li><li><p><strong>&#8220;Content&#8221;</strong>&#160;means&#10; any text, graphics, images, audio, video, software, data compilations &#10;including, but not limited to, text, graphics, logos, icons, sound &#10;clips, video clips, data compilations, page layout, underlying code and &#10;software and any other form of information capable of being stored in a &#10;computer that appears on, is uploaded to or forms part of this Website &#10;or the Services or the Platform; BUT excluding User Content;</p></li><li><p><strong>&#8220;Database&#8221;</strong>&#160;means the database stored on the Platform which contains inter alia User Content;</p></li><li><p><strong>&#8220;Data Controller&#8221;</strong>, &#8220;Data Processor&#8221; and &#8220;Personal Data&#8221; &#8220;processing&#8221; and &#8220;data subject&#8221; shall have the meanings ascribed to them in the GDPR;</p></li><li><p><strong>&#8220;DPA&#8221;</strong>&#160;means the Data Protection Act 2018 and any modification, amendment or re-enactment thereof;</p></li><li><p><strong>&#8220;Documentation&#8221;</strong>&#160;means&#10; user documentation provided electronically by Shephard &amp; Co for use&#10; with the Subscription Services, as periodically updated;</p></li><li><p><strong>&#8220;End User(s)&#8221;</strong>&#160;means a customer or customers of the Customer and/or any third party or parties for whom the Customer generates a Report;</p></li><li><p><strong>&#8220;Force Majeure&#8221;</strong>,&#10; means circumstances beyond the control of Shephard &amp; Co which shall&#10; include (but shall not be limited to) acts of God, perils of the sea or&#10; air, fire, flood, drought, explosion, sabotage, accident, embargo, &#10;riot, civil commotion, including acts of local government and &#10;parliamentary authority; inability to supply the Software Services, &#10;materials, breakdown of Local Equipment and labour disputes of whatever &#10;nature and for whatever cause arising including (but without prejudice &#10;to the generality of the foregoing) work to rule, overtime bars, strikes&#10; and lockouts and whether between either of the parties hereto and any &#10;or all of its employees and/or any other employer and any or all of its &#10;employees and/or between any two or more groups of employees (and &#10;whether of either of the parties hereto or any other employer);</p></li><li><p><strong>&#8220;GDPR&#8221;</strong>&#160;means the General Data Protection Regulation (Regulation (EU) 2016/679);</p></li><li><p><strong>&#8220;HMRC&#8221;</strong>&#160;means Her Majesty\'s Revenue and Customs;</p></li><li><p><strong>&#8220;ICO&#8221;</strong>&#160;means the UK&#8217;s supervisory authority, the Information Commissioner&#8217;s Office;</p></li><li><p><strong>&#8220;Industry Best Practice&#8221;</strong>&#160;means&#10; the standard of care, attention, diligence, expertise, knowledge, &#10;methods and practice expected of a competent and experienced &#10;professional in the IT and Cyber Security profession;</p></li><li><p><strong>&#8220;Local Equipment&#8221;</strong>&#160;means&#10; the Customer or User&#8217;s own on-premise equipment including hardware and &#10;software environment which is used in connection with the Software &#10;Services, which comprise of, but is not limited to - server computers &#10;(whether virtual or not), Desktop PC&#8217;s, Laptops or any other portable &#10;device, storage systems and relative hardware, firmware, operating &#10;software, operating system software, networking software, database &#10;software, anti-virus and security software, switches, power supplies and&#10; telecommunications infrastructure, internet connection, broadband &#10;availability and infrastructure, routers, Printers, associated &#10;peripheral devices or accessories whether fixed or portable;</p></li><li><p><strong>&#8220;Order Form&#8221;</strong>&#160;means&#10; a document provided by Shephard &amp; Co and signed by the Customer &#10;that describes the Subscription Services and Professional Services being&#10; purchased and/or licensed by the Customer in terms of this Agreement &#10;and any additional conditions pertaining thereto;</p></li><li><p><strong>&#8220;Personal Data&#8221;</strong>&#160;means all such &#8220;personal data&#8221;, as defined in Article 4 of the GDPR;</p></li><li><p><strong>&#8220;Platform&#8221;</strong>&#160;means&#10; the hardware and software environment in which the software element of &#10;the Subscription Services operates, which comprises one or more server &#10;computers (whether virtual or not), mirroring/duplicating/back-up and &#10;storage systems and relative hardware operating software, virtual &#10;machine software (where relevant), operating system software, database &#10;software, anti-virus and security software, switches, power supplies and&#10; telecommunications infrastructure;</p></li><li><p><strong>&#8220;Privacy Policy&#8221;</strong>&#160;means&#10; Shephard &amp; Co&#8217; policy relating to User Content and compliance with &#10;(amongst others) the DPA and the GDPR from time to time, the current &#10;version of which is located here [insert link to Privacy Policy];</p></li><li><p><strong>&#8220;Professional Services&#8221;</strong>&#160;means&#10; the training, consulting, development and other professional services &#10;identified on an Order Form but does not include the Subscription &#10;Services;</p></li><li><p><strong>&#8220;Report&#8221;</strong>&#160;means the output from&#10; the Software in the form of a report pertaining to a specific End User &#10;which is generated from data obtained from and specific to a particular &#10;End User;</p></li><li><p><strong>&#8220;SLA&#8221;</strong>&#160;means a Service Level Agreement in the form set out in Part 5 of these terms;</p></li><li><p><strong>&#8220;SME&#8221;</strong>&#160;means small and medium-sized enterprise(s);</p></li><li><p><strong>&#8220;Software&#8221;</strong>&#160;means&#10; the Shephard &amp; Co&#8482; proprietary operating software and the third &#10;party software written in object and source code residing on and used &#10;for operating the Platform and the Subscription Services as Updated and &#10;Upgraded from time to time;</p></li><li><p><strong>&#8220;Sub-Processor&#8221;</strong>&#160;means a sub-processor appointed by Shephard &amp; Co to process the Personal Data;</p></li><li><p><strong>&#8220;Sub-Processing Agreement&#8221;</strong>&#160;means&#10; an agreement between Shephard &amp; Co and a Sub-Processor governing &#10;the Personal Data processing carried out by the Sub-Processor, as &#10;described in Clause 21;</p></li><li><p><strong>&#8220;Subscription Services&#8221;</strong>&#160;means&#10; the hosted the Customer experience solutions identified in an Order &#10;Form, and any modifications periodically made by Shephard &amp; Co, but &#10;does not include the Professional Services;</p></li><li><p><strong>&#8220;Subscription Term&#8221;</strong>&#160;means&#10; the period of time during which Shephard &amp; Co is required to &#10;provide the Customer with the Subscription Services as specified in the &#10;relevant Order Form;</p></li><li><p><strong>&#8220;Update&#8221;</strong>&#160;means any &#10;update, update rollup, service pack, feature pack, critical update, &#10;security update, or hotfix that is used to improve or to fix a software &#10;product;</p></li><li><p><strong>&#8220;Upgrade&#8221;</strong>&#160;means a software &#10;package that replaces an installed version of a product with a newer &#10;version of the same product, typically leaving existing customer data &#10;and preferences intact while replacing the existing software with the &#10;newer version;</p></li><li><p><strong>&#8220;User&#8221;</strong>&#160;means the Customer&#10; and any of its employees, or of a person to whom the Customer has &#10;outsourced services, that has permission to accesses the Subscription &#10;Services as a named user and is not employed by Shephard &amp; Co and &#10;acting in the course of their employment;</p></li><li><p><strong>&#8220;User Content&#8221;</strong>&#160;means&#10; any text, graphics, images, audio, video, software, data compilations &#10;and any other form of information capable of being stored in a computer &#10;that appears on, is uploaded to or forms part of a User Site or the &#10;Subscription Services and has been uploaded by a User or End User [or by&#10; Shephard &amp; Co on behalf of a User or End User];</p></li></ol><div align=\"left\"><p><strong>&#8220;User Site&#8221;</strong>&#160;means&#10; a partition or tenancy on the Platform created by Shephard &amp; Co for&#10; a User or Users accessing the Subscription Services which shall contain&#10; User Content and shall be hosted on the Platform;</p></div></li></ol>', 1, '2020-06-11 11:50:17', '2020-08-07 04:58:38');
INSERT INTO `cms` (`id`, `added_by`, `cms_title`, `cms_slug`, `cms_meta_title`, `cms_meta_keyword`, `cms_meta_description`, `cms_detail`, `cms_status`, `created_at`, `updated_at`) VALUES
(14, 0, 'Privacy Policy', 'privacy-policy', 'Privacy Policy', 'Privacy Policy', 'Privacy Policy', '<h2>Background</h2><h2>In this Policy, unless specified otherwise, words and phrases shall have the same meanings as specified in our Terms and Conditions.</h2><p><strong>TGG Ltd</strong>, a company incorporated in England (Registered Number 10754811), and having its Registered Office at Unit 8, Edward Court, Altrincham Business Park, WA14 5GL, trading as&#160;<strong>Shephard &amp; Co</strong>&#160;understands that your privacy is important to you and that you care about how your personal data is used and shared online. We respect and value the privacy of Customers and will only collect and use personal data in ways that are described here, and in a manner that is consistent with Our obligations and your rights under the law.</p><p>Please read this Privacy Policy carefully and ensure that you understand it. You will be required to read and accept this Privacy Policy when signing up for an Account. If you do not accept and agree with this Privacy Policy, you will not be able to purchase Our Subscription Services.</p><ol><li><strong>Definitions and Interpretation</strong><p>In this Policy, the following terms shall have the following meanings:</p><p><strong>&#34;Account&#34;</strong></p><p>means an account required to access and/or use Our Subscription Service(s);</p><p><strong>&#34;Cookie&#34;</strong></p><p>means a small text file placed on your computer or device by Our Subscription Services when you visit certain parts of Our Subscription Services and/or when you use certain features of Our Subscription Services. Details of the Cookies used by Our Subscription Services are set out in section 12, below;</p><p><strong>&#34;Cookie Law&#34;</strong></p><p>means the relevant parts of the Privacy and Electronic Communications (EC Directive) Regulations 2003</p><p><strong>&#34;Personal Data&#34;</strong></p><p>means any and all data that relates to an identifiable person who can be directly or indirectly identified from that data. In this case, it means personal data that you give to Us via Our Subscription Services. This definition shall, where applicable, incorporate the definitions provided in the EU Regulation 2016/679 &#8211; the General Data Protection Regulation (&#8220;GDPR&#8221;); and</p><p><strong>&#34;We/Us/Our&#34;</strong></p><p>means the said Shephard &amp; Co (as above).</p></li><li><strong>Information About Us</strong><ol><li><p>Our VAT number is 289648530.</p></li><li><p>Our Data Protection Officer is Jen Smeed and can be contacted by email at dpo@Shephard &amp; Co.co.uk, or by post at Drake House, Gadbrook Park, Northwich, England, CW9 7RA.</p></li></ol></li><li><strong>What Does This Policy Cover?</strong><p>This Privacy Policy applies only to our use of data gathered by Us in your use of the Subscription Services.</p></li><li><strong>Your Rights</strong><ol><li><p>As a data subject, you have the following rights under the GDPR, which this Policy and Our use of personal data have been designed to uphold:</p><ol><li><p>The right to be informed about Our collection and use of personal data;</p></li><li><p>The right of access to the personal data We hold about you or your clients (see section 11);</p></li><li><p>The right to rectification if any personal data We hold about you or your clients is inaccurate or incomplete (please contact Us using the details in section 13);</p></li><li><p>The right to be forgotten &#8211; i.e. the right to ask Us to delete any personal data We hold about you or your or clients (We only hold personal data for a limited time, as explained in section 6 but if you would like Us to delete it sooner, please contact Us using the details in section 13). Please note that deletion of certain personal data may prevent the Subscription Services from functioning;</p></li><li><p>The right to restrict (i.e. prevent) the processing of personal data;</p></li><li><p>The right to data portability (obtaining a copy of personal data to re-use with another service or organisation);</p></li><li><p>The right to object to Us using personal data for particular purposes; and</p></li><li><p>Rights with respect to automated decision making and profiling.</p></li></ol></li><li><p>If you have any cause for complaint about Our use of personal data, please contact Us using the details provided in section 13 and We will do Our best to solve the problem for you. If We are unable to help, you also have the right to lodge a complaint with the UK&#8217;s supervisory authority, the Information Commissioner&#8217;s Office, details of which can be found here https://ico.org.uk/.</p></li></ol></li><li><strong>What Data Do We Collect?</strong><p>We may collect some or all of the following personal and non-personal data:</p><ol><li><p>name;</p></li><li><p>date of birth;</p></li><li><p>gender;</p></li><li><p>business/company name;</p></li><li><p>job title;</p></li><li><p>profession;</p></li><li><p>contact information such as email addresses and telephone numbers;</p></li><li><p>demographic information such as post code, preferences, and interests;</p></li><li><p>financial information such as credit / debit card numbers;</p></li><li><p>IP address;</p></li><li><p>web browser type and version;</p></li><li><p>operating system;</p></li><li><p>a list of URLs starting with a referring site, your activity on Our Subscription Services, and the site you exit to;</p></li></ol></li><li><strong>How Do We Use Your Data?</strong><ol><li><p>All personal data is processed and stored securely, for no longer than is necessary in light of the reason(s) for which it was first collected. We will comply with Our obligations and safeguard your rights under the GDPR at all times. For more details on security see section 7, below.</p></li><li><p>Our use of personal data will always have a lawful basis, either because it is necessary for Our performance of a contract with you, because you have consented to Our use of personal data (e.g. by subscribing to emails or for delivery of the Subscription Services), or because it is in Our legitimate interests. Specifically, We may use personal data for the following purposes:</p><ol><li><p>Providing and managing your Account;</p></li><li><p>Providing and managing your access to the Subscription Services;</p></li><li><p>Personalising and tailoring your experience in the Subscription Services;</p></li><li><p>Supplying Our services to you (please note that We require your personal data in order to enter into a contract with you);</p></li><li><p>Personalising and tailoring Our services for you;</p></li><li><p>Replying to emails, messages or support requests from you;</p></li><li><p>Supplying you with emails that you have opted into (you may unsubscribe or opt-out at any time by clicking unsubscribe within the email.</p></li><li><p>Market research;</p></li><li><p>Analysing your use of Our Subscription Services and gathering feedback to enable Us to continually improve Our Subscription Services and your user experience;</p></li></ol></li><li><p>With your permission and/or where permitted by law, We may also use your data for marketing purposes which may include contacting you by email, telephone, text message and post with information, news and offers on Our services. We will not, however, send you any unsolicited marketing or spam and will take all reasonable steps to ensure that We fully protect your rights and comply with Our obligations under the GDPR and the Privacy and Electronic Communications (EC Directive) Regulations 2003.</p></li><li><p>You have the right to withdraw your consent to Us using your personal data at any time, and to request that We delete it; however this may adversely affect the delivery, use and function of the Subscription Services.</p></li><li><p>We do not keep personal data for any longer than is necessary in light of the reason(s) for which it was first collected. Data will therefore be retained for the following periods (or its retention will be determined on the following bases):</p><ol><li><p>for a period of two years after you cease to be a Customer.</p></li></ol></li></ol></li><li><strong>How and Where Do We Store Your Data?</strong><ol><li><p>We only keep personal data for as long as We need to in order to use it as described above in section 6, and/or for as long as We have your permission to keep it.</p></li><li><p>Some or all of your data may be stored or transferred outside of the EEA. You are deemed to accept and agree to this by using the App and submitting information to Us. If We do store or transfer data outside the EEA, We will take all reasonable steps to ensure that your data is treated as safely and securely as it would be within the EEA and under the GDPR. Such steps may include, but not be limited to, the use of legally binding contractual terms between Us and any third parties We engage and the use of the EU-approved Model Contractual Arrangements or in the United States of America, Privacy Shield. Data security is very important to Us, and to protect your data We have taken suitable measures to safeguard and secure data.</p></li></ol></li><li><strong>Do We Share Your Data?</strong><ol><li><p>We may sometimes contract with third parties to supply products and services to you on Our behalf. These may include payment processing, delivery of goods, search engine facilities, advertising, and marketing. In some cases, the third parties may require access to some or all of your data. Where any of your data is required for such a purpose, We will take all reasonable steps to ensure that your data will be handled safely, securely, and in accordance with your rights, Our obligations, and the obligations of the third party under the law.</p></li><li><p>We may compile statistics about the use of products and services including the Subscription Services including data on traffic, usage patterns, user numbers, sales, and other information. All such data will be anonymised and will not include any personally identifying data, or any anonymised data that can be combined with other data and used to identify you or your employees [or customers]. We may from time to time share such data with third parties such as prospective investors, affiliates, partners, and advertisers. Data will only be shared and used within the bounds of the law.</p></li><li><p>The third party data processors used by Us and listed below are located outside the European Economic Area (&#8220;the EEA&#8221;) (The EEA consists of all EU member states, plus Norway, Iceland, and Liechtenstein). Where We transfer any personal data outside the EEA, We will take all reasonable steps to ensure that your data is treated as safely and securely as it would be within the UK and under the GDPR:</p><ol><li><p>for further details please visit https://www.heroku.com</p></li></ol></li><li><p>In certain circumstances, We may be legally required to share certain data held by Us, which may include your personal data, for example, where We are involved in legal proceedings, where We are complying with legal requirements, a court order, or a governmental authority.</p></li></ol></li><li><strong>What Happens If Our Business Changes Hands?</strong><ol><li><p>We may, from time to time, expand or reduce Our business and this may involve the sale and/or the transfer of control of all or part of Our business. Any personal data that you have provided will, where it is relevant to any part of Our business that is being transferred, be transferred along with that part and the new owner or newly controlling party will, under the terms of this Privacy Policy, be permitted to use that data only for the same purposes for which it was originally collected by Us.</p></li></ol></li><li><strong>How Can You Control Your Data?</strong><ol><li><p>When you submit personal data to us, you may be given options to restrict Our use of your data. In particular, We aim to give you strong controls on Our use of your data for direct marketing purposes (including the ability to opt-out of receiving emails from Us which you may do by unsubscribing using the links provided in Our emails and at the point of providing your details and by managing your Account).</p></li><li><p>You may also wish to sign up to one or more of the preference services operating in the UK: The Telephone Preference Service (&#8220;the TPS&#8221;), the Corporate Telephone Preference Service (&#8220;the CTPS&#8221;), and the Mailing Preference Service (&#8220;the MPS&#8221;). These may help to prevent you receiving unsolicited marketing. Please note, however, that these services will not prevent you from receiving marketing communications that you have consented to receiving.</p></li></ol></li><li><strong>How Can You Access Your Data?</strong><p>You have the right to ask for a copy of any of your personal data held by Us (where such data is held). Please contact Us for more details using the contact details below in section 13.</p></li><li><strong>Our Use of Cookies</strong><ol><li><p>Our Subscription Services do not use any first party Cookies. By using Our Subscription Services you may also receive certain third party Cookies on your computer or device. Third party Cookies are those placed by websites, services, and/or parties other than Us. For more details, please refer section 12.6 below.</p></li><li><p>All Cookies used by and on Our Subscription Services are used in accordance with current Cookie Law.</p></li><li><p>Before Cookies are placed on your computer or device, you will be shown a banner message requesting your consent to set those Cookies. By giving your consent to the placing of Cookies you are enabling Us to provide the best possible experience and service to you. You may, if you wish, deny consent to the placing of Cookies; however certain features of Our Subscription Services may not function fully or as intended.</p></li><li><p>Certain features of Our Subscription Services depend on Cookies to function. Cookie Law deems these Cookies to be &#8220;strictly necessary&#8221;. These Cookies are shown below in section 12.6. Your consent will not be sought to place these Cookies, but it is still important that you are aware of them. You may still block these Cookies by changing your internet browser&#8217;s settings as detailed below in section 12.10, but please be aware that Our Subscription Services may not work properly if you do so. We have taken great care to ensure that your privacy is not at risk by allowing them.</p></li><li><p>The following first party Cookies may be placed on your computer or device:</p><table class=\" cke_show_border\"><thead><tr><th>Name of Cookie</th><th>Purpose</th><th>Strictly Necessary</th></tr></thead><tbody><tr><td>-</td><td>-</td><td>-</td></tr><tr><td>-</td><td>-</td><td>-</td></tr></tbody></table></li><li><p>and the following third-party Cookies may be placed on your computer or device:</p><table class=\" cke_show_border\"><thead><tr><th>Name of Cookie</th><th>Provider</th><th>Purpose</th></tr></thead><tbody><tr><td>-</td><td>-</td><td>-</td></tr><tr><td>-</td><td>-</td><td>-</td></tr></tbody></table></li><li><p>We use analytics services provided by provided by Google. Website analytics refers to a set of tools used to collect and analyse anonymous usage information, enabling Us to better understand how Our Subscription Services are used. This, in turn, enables Us to improve Our Subscription Services and the products and services offered through it. You do not have to allow Us to use these Cookies, however whilst Our use of them does not pose any risk to your privacy or your safe use of Our Subscription Services, it does enable Us to continually improve Our Subscription Services, making it a better and more useful experience for you.</p></li><li><p>The analytics services used by Our Subscription Services use Cookies to gather the required information.</p></li><li><p>The analytics services used by Our Subscription Services use the following Cookies:</p><table class=\" cke_show_border\"><thead><tr><th>Name of Cookie</th><th>First/Third Party</th><th>Provider</th><th>Purpose</th></tr></thead><tbody><tr><td>Google Analytics</td><td>Third</td><td>Google</td><td>To improve our understanding of how Customers use our system</td></tr><tr><td>Google Analytics</td><td>Third</td><td>Google</td><td>To improve our understanding of how Customers use our system</td></tr></tbody></table></li><li><p>In addition to the controls that We provide, you can choose to enable or disable Cookies in your internet browser. Most internet browsers also enable you to choose whether you wish to disable all cookies or only third party Cookies. By default, most internet browsers accept Cookies but this can be changed. For further details, please consult the help menu in your internet browser or the documentation that came with your device.</p></li><li><p>You can choose to delete Cookies on your computer or device at any time, however you may lose any information that enables you to access Our Subscription Services more quickly and efficiently including, but not limited to, login and personalisation settings.</p></li><li><p>It is recommended that you keep your internet browser and operating system up-to-date and that you consult the help and guidance provided by the developer of your internet browser and manufacturer of your computer or device if you are unsure about adjusting your privacy settings.</p></li></ol></li><li><strong>Contacting Us</strong><p>If you have any questions about Our Subscription Services or this Privacy Policy, please contact Us by email at dpo@Shephard &amp; Co.co.uk or by post at Drake House, Gadbrook Park, Northwich, England, CW9 7RA. Please ensure that your query is clear, particularly if it is a request for information about the data We hold about you (as under section 11, above).</p></li><li><strong>Changes to Our Privacy Policy</strong><p>We may change this Privacy Policy from time to time (for example, if the law changes). Any changes will be immediately posted on Our Subscription Services and you will be deemed to have accepted the terms of the Privacy Policy on your first use of Our Subscription Services following the alterations. We recommend that you check this page regularly to keep up-to-date.</p></li></ol>', 1, '2020-06-13 14:44:35', '2020-07-23 08:29:07');

-- --------------------------------------------------------

--
-- Table structure for table `commercial_goals`
--

CREATE TABLE `commercial_goals` (
  `id` int(11) NOT NULL,
  `claim_id` bigint(20) NOT NULL,
  `markets` text,
  `competition` text,
  `scale` text,
  `processess` text,
  `products` text,
  `finance` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `commercial_goals`
--

INSERT INTO `commercial_goals` (`id`, `claim_id`, `markets`, `competition`, `scale`, `processess`, `products`, `finance`, `created_at`) VALUES
(1, 3, 'Did some work to understand our markets better', 'Caught up with advances in our competitions', 'Expanded to more sites', NULL, NULL, NULL, '2020-08-07 08:29:56'),
(2, 1, 'Did some work to understand our markets better', 'Moved ahead of our competitors', 'Increased production Capacity', 'Improved our business processes', 'Developed one or more new products or services', 'Reduced Staff', '2020-08-07 11:39:33'),
(3, 9, 'Did some work to understand our markets better', 'Caught up with advances in our competitions', NULL, NULL, NULL, NULL, '2020-08-07 13:14:22'),
(4, 10, 'Did some work to understand our markets better', NULL, NULL, NULL, NULL, NULL, '2020-08-10 04:55:28'),
(5, 14, 'Did some work to understand our markets better', NULL, NULL, NULL, NULL, NULL, '2020-08-10 09:27:34'),
(6, 15, NULL, NULL, 'Increased production Capacity', 'Improved our business processes', 'Developed one or more new products or services', NULL, '2020-09-09 09:55:01'),
(7, 16, 'Repositioned our offers', NULL, 'Increased production Capacity', 'Improved our business processes', 'Improved one or more products in a way that can be measured', NULL, '2020-09-09 10:00:43'),
(8, 17, 'Did some work to understand our markets better', NULL, 'Increased production Capacity', 'Improved our manufacturing processes', 'Developed one or more new products or services', NULL, '2020-09-10 08:31:31'),
(9, 18, 'Diversified into new markets', NULL, 'Expanded to more sites', 'Improved our business processes', 'Improved one or more products in a way that can be measured', NULL, '2020-09-14 08:58:43'),
(10, 19, 'Diversified into new markets', NULL, NULL, 'Implemented more efficient equipment / machinery', 'Developed one or more new products or services', NULL, '2020-09-14 12:34:41');

-- --------------------------------------------------------

--
-- Table structure for table `company_about`
--

CREATE TABLE `company_about` (
  `about_id` bigint(20) UNSIGNED NOT NULL,
  `claim_id` int(11) NOT NULL,
  `about` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `company_about`
--

INSERT INTO `company_about` (`about_id`, `claim_id`, `about`, `created_at`, `updated_at`) VALUES
(6, 3, 'fdghdfgfdg', '2020-08-07 09:24:15', NULL),
(8, 5, 'dafsdsdfsdf', '2020-08-07 10:12:02', NULL),
(14, 6, 'efewrtr', '2020-08-07 12:08:48', NULL),
(25, 9, '3333', '2020-08-07 13:16:25', NULL),
(33, 1, 'adsfsdfsdf', '2020-08-07 13:48:45', NULL),
(58, 10, 'sdfasdddd', '2020-09-01 13:43:56', NULL),
(60, 16, 'Promotional Mailing Services Group Ltd is one of a select few promotional fulfilment houses offering over 50 years of professional and reliable service. Established in 1964, we handle everything from one-off promotion and direct mail to on-going promotional storage and distribution throughout the UK, EMEA and Worldwide.\n\nOur fully integrated, web-based, end-to-end system can be tailored to meet our client’s requirements, however complex, offering a reliable and fast service.', '2020-09-09 09:57:24', NULL),
(61, 15, 'Promotional Mailing Services Group Ltd is one of a select few promotional fulfilment houses offering over 50 years of professional and reliable service. Established in 1964, we handle everything from one-off promotion and direct mail to on-going promotional storage and distribution throughout the UK, EMEA and Worldwide.\n\nOur fully integrated, web-based, end-to-end system can be tailored to meet our client’s requirements, however complex, offering a reliable and fast service.', '2020-09-09 10:59:26', NULL),
(66, 14, 'kjgdfkgkjd fgksdhkhkshkd fskdhfkhskhkdhfkjgdfkgkjd fgksdhkhkshkd fskdhfkhskhkdhfkjgdfkgkjd fgksdhkhkshkd fskdhfkhskhkdhfkjgdfkgkjd fgksdhkhkshkd fskdhfkhskhkdhfkjgdfkgkjd fgksdhkhkshkd fskdhfkhskhkdhfkjgdfkgkjd fgksdhkhkshkd fskdhfkhskhkdhfkjgdfkgkjd fgksdhkhkshkd fskdhfkhskhkdhfkjgdfkgkjd fgksdhkhkshkd fskdhfkhskhkdhf', '2020-09-10 09:58:48', NULL),
(70, 18, 'The Oaks main building was constructed between 1785 and 1790 by James Acheson, a prominent business man in the City of Derry. Before that the townlands of Stathall & Tamneymore, which comprises the demesne, were hotly sought after due to its geographical nature and positioning on the River Faughan.\n\nOriginally thought to be part of the Goldsmiths Company lands it was in fact a Freehold gifted to John Freeman in the early 1600’s. After the lands were vested from the Acheson & Lyle families by the Irish Land Commission it was then sold to the Allen’s post 1921.\n\nThe Oaks has remained a family home and a undiscovered jewel in the Faughan Valley...until now.\n\nThere are many plans for the future and with impressive woodland walks nearby it will soon be a recreational destination of epic proportions allowing anyone and everyone access to the countryside.\n\nWith Derry-Londonderry no more than 5 minutes away, The Oaks Demesne has recently hosted obstacle course challenges and outdoor activities since 2006.\n\nWe hope you enjoy our luscious scenery, breath taking woodlands, magnificent experiences and welcoming hospitality.\n\nThe Oaks has been home to many people over the years and has always been closely linked to the people & communities surrounding the area.\n\nOne such neighbour is The Woodland Trust who have invested greatly in the Valley creating one of four centenary destinations across the UK, the other three being in Wales, England and Scotland.\n\nThere has been many ventures from bleaching mills, agricultural endeavours, breweries, bee hives and much more.', '2020-09-14 12:14:52', NULL),
(72, 19, 'Make is a young, tight-knit and fast growing team of professionals, specialising in the latest website development and digital marketing trends.\n\nWith an average age of just 27, we’re at the heart of the digital revolution, yes, we may be creatively driven, but we also understand the cost and time pressures most businesses face.', '2020-09-14 12:44:30', NULL),
(74, 17, 'Eprotek offer expert advice and manufacturing services to high technology electronics companies and specialise in working with start-ups and design houses. Services include New Product Introduction (NPI), Prototyping, Engineering and Small Batch Assembly.\n\nEprotek assemble, rework and modify some of the most advanced, state-of-the-art circuit boards in areas such as Embedded Solutions, Networking, Aerospace, Imaging Systems and FPGA Platforms.\n\nPreviously known as Electronic Manufacturing Services, Eprotek has been led by Robert Walker since 1994. Now operating as an independent company, Eprotek offer the same impeccable customer service which has gained Robert Walker and his team a UK-wide reputation.', '2020-09-15 11:32:38', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `company_claims`
--

CREATE TABLE `company_claims` (
  `cid` bigint(20) UNSIGNED NOT NULL,
  `claim_id` bigint(20) NOT NULL,
  `number_of_directors` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `number_of_staff` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `year_end_date` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `profit_loss` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `turnover` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `gross_balance_sheet` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `grants` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `property_ownership` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `part_of_group` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name_of_group` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `percentage_own` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `about_us` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `company_claims`
--

INSERT INTO `company_claims` (`cid`, `claim_id`, `number_of_directors`, `number_of_staff`, `year_end_date`, `profit_loss`, `turnover`, `gross_balance_sheet`, `grants`, `property_ownership`, `part_of_group`, `name_of_group`, `percentage_own`, `about_us`, `created_at`, `updated_at`) VALUES
(6, 3, '12', '12', '2020-06-04', '111', '11', '11', '11', 'leased-premises', '0', NULL, NULL, NULL, '2020-08-07 09:24:11', NULL),
(16, 5, '2342', '3', '2020-06-04', '345', '452424', '2323', '234234', 'leased-premises', '1', 'tami', '3', NULL, '2020-08-07 12:01:52', '2020-08-07 12:01:52'),
(19, 6, '2342', '3', '2020-06-04', '32452345', '34253245', '345324523', '345345', 'leased-premises', '1', 'qweq', '8', NULL, '2020-08-07 12:08:46', '2020-08-07 12:08:46'),
(40, 9, '40', '44', '2020-06-04', '33', '33', '333', '3', 'owned', NULL, NULL, NULL, NULL, '2020-08-07 13:16:21', NULL),
(51, 1, '40', '44', '2020-06-04', '22222', '2222', '222', '22', 'owned', '1', '22', '13', NULL, '2020-08-07 13:46:50', '2020-08-07 13:46:50'),
(76, 10, '525', '525', '2020-06-04', '4548', '5353', '6353', '5235', 'leased-premises', '1', 'Westren', '5', NULL, '2020-09-01 13:43:54', '2020-09-01 13:43:54'),
(79, 16, '2', '15', '2019-10-31', '364346', '1500000', '50000', '0', 'leased-premises', NULL, NULL, NULL, NULL, '2020-09-09 09:57:17', NULL),
(80, 15, '2', '15', '2018-10-31', '230980', '2000000', '50000', '0', 'leased-premises', NULL, NULL, NULL, NULL, '2020-09-09 10:59:25', NULL),
(85, 14, '2111111111111', '1222222222222', '2020-06-04', '66333333333333', '12444444444444', '2555555555555', '0666666666666', 'owned', NULL, NULL, NULL, NULL, '2020-09-10 09:58:47', NULL),
(89, 18, '1', '4', '2020-06-04', '-89035', '129275', '200000', '0', 'owned', NULL, NULL, NULL, NULL, '2020-09-14 12:14:51', NULL),
(91, 19, '2', '5', '2018-12-28', '193097', '601173', '50000', '0', 'leased-premises', NULL, NULL, NULL, NULL, '2020-09-14 12:40:43', NULL),
(93, 17, '1', '1', '2019-07-31', '110942', '311829', '30000', '0', 'leased-premises', NULL, NULL, NULL, NULL, '2020-09-15 11:32:37', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `company_invites`
--

CREATE TABLE `company_invites` (
  `invite_id` bigint(20) UNSIGNED NOT NULL,
  `invite_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `claim_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  `invite_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `invite_email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `invite_roles` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `company_invites`
--

INSERT INTO `company_invites` (`invite_id`, `invite_token`, `claim_id`, `user_id`, `client_id`, `invite_name`, `invite_email`, `invite_roles`, `status`, `created_at`, `updated_at`) VALUES
(1, '588eabcc92bf9e7d22d8208561a6b978', 1, 70, 1, 'tridentresumesmes', 'hociho2897@ainbz.com', 'Projects,Costs,Technical,Declaration & T&C', 1, '2020-08-06 14:16:43', NULL),
(18, '675de67ad7a1a7a8ce55f6f10e6bb5ba', 1, 70, 1, 'ssss', 'democoder3535@gmail.com', 'Projects', 1, '2020-08-07 07:36:18', NULL),
(19, '028c445f97c5c9353b164450b34d4693', 3, 70, 2, 'kjhk', 'haider@emworx.com', 'Projects', 1, '2020-08-07 08:02:11', NULL),
(20, '28ba9a03e3e27ee90f03f3575e732287', 6, 70, 1, 'democoder35 demo', 'democoder3535@gmail.com', 'Projects', 1, '2020-08-07 11:26:21', NULL),
(21, '090a99ef6e41291bb34c088953306da7', 6, 70, 1, 'sdfsdf', 'webtester0722@gmail.com', 'Projects,Costs,Technical,Declaration & T&C', 1, '2020-08-07 12:09:09', NULL),
(22, '21ceddf7fb1c80f60ef8a7d02db32206', 6, 70, 1, 'asdddddd', 'democoder3535@gmail.com', 'Projects,Costs,Technical,Declaration & T&C', 1, '2020-08-07 12:10:07', NULL),
(23, '987605ab9df1486512bb8d425ffadcd9', 9, 70, 1, 'tridentresumes - Tridentresumes', 'webtester0722@gmail.com', 'Projects,Costs,Technical,Declaration & T&C', 1, '2020-08-07 12:24:19', NULL),
(25, '1ba52ff97e3e04bdb64cad4172842244', 10, 70, 1, 'tridentresus', 'webtester0722@gmail.com', 'Projects,Costs,Technical,Declaration & T&C', 1, '2020-08-10 04:53:12', NULL),
(28, 'dd654356c8a14888f803bb712c397693', 14, 70, 1, 'Test name4', 'testautomation12334@yopmail.com', 'Projects,Costs,Technical,Declaration & T&C', 1, '2020-08-12 11:15:36', NULL),
(34, 'dd955a4d1d288315bb8273057785dc5c', 10, 70, 1, 'asdsd', 'vishal@gsquarewebtech.com', 'Projects,Costs,Technical,Declaration & T&C', 1, '2020-09-01 13:45:31', NULL),
(37, '7e6e9c1e179e4e0ec6b6e7b3ba2db702', 14, 71, 1, 'Greg', 'G.m.parry@outlook.com', 'Projects,Costs,Technical,Declaration & T&C', 0, '2020-09-10 09:56:02', '2020-09-10 09:57:21'),
(38, '09b02612eb4870fe61713c73558b35fb', 18, 71, 6, 'Richard', 'Info@oakfireadventures.com', 'Costs,Declaration & T&C', 1, '2020-09-14 10:27:01', NULL),
(39, '51d343e09bbb4966988bf767f1d6cc6a', 17, 71, 5, 'Rob Walker', 'Rab.eprotek@gmail.com', 'Costs,Declaration & T&C', 0, '2020-09-14 14:09:57', '2020-09-15 09:23:41');

-- --------------------------------------------------------

--
-- Table structure for table `company_invite_permissions`
--

CREATE TABLE `company_invite_permissions` (
  `id` bigint(20) NOT NULL,
  `invite_id` bigint(20) NOT NULL,
  `permission_key` varchar(20) NOT NULL,
  `permission_value` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `company_invite_permissions`
--

INSERT INTO `company_invite_permissions` (`id`, `invite_id`, `permission_key`, `permission_value`) VALUES
(1, 1, 'projects', '1'),
(2, 1, 'staffCosts', '1'),
(3, 1, 'epwCosts', '1'),
(4, 1, 'subcontractorCosts', '1'),
(5, 1, 'consumableCosts', '1'),
(6, 1, 'softwareCosts', '1'),
(7, 1, 'expenses', '1'),
(8, 1, 'commercialGoals', '1'),
(9, 1, 'aims', '1'),
(10, 1, 'difficulties', '1'),
(11, 1, 'technicalChallenges', '1'),
(12, 1, 'nonTechAreas', '1'),
(13, 1, 'declaration', '1'),
(222, 18, 'projects', '1'),
(223, 18, 'staffCosts', '0'),
(224, 18, 'epwCosts', '0'),
(225, 18, 'subcontractorCosts', '0'),
(226, 18, 'consumableCosts', '0'),
(227, 18, 'softwareCosts', '0'),
(228, 18, 'expenses', '0'),
(229, 18, 'commercialGoals', '0'),
(230, 18, 'aims', '0'),
(231, 18, 'difficulties', '0'),
(232, 18, 'technicalChallenges', '0'),
(233, 18, 'nonTechAreas', '0'),
(234, 18, 'declaration', '0'),
(235, 19, 'projects', '1'),
(236, 19, 'staffCosts', '0'),
(237, 19, 'epwCosts', '0'),
(238, 19, 'subcontractorCosts', '0'),
(239, 19, 'consumableCosts', '0'),
(240, 19, 'softwareCosts', '0'),
(241, 19, 'expenses', '0'),
(242, 19, 'commercialGoals', '0'),
(243, 19, 'aims', '0'),
(244, 19, 'difficulties', '0'),
(245, 19, 'technicalChallenges', '0'),
(246, 19, 'nonTechAreas', '0'),
(247, 19, 'declaration', '0'),
(248, 20, 'projects', '1'),
(249, 20, 'staffCosts', '0'),
(250, 20, 'epwCosts', '0'),
(251, 20, 'subcontractorCosts', '0'),
(252, 20, 'consumableCosts', '0'),
(253, 20, 'softwareCosts', '0'),
(254, 20, 'expenses', '0'),
(255, 20, 'commercialGoals', '0'),
(256, 20, 'aims', '0'),
(257, 20, 'difficulties', '0'),
(258, 20, 'technicalChallenges', '0'),
(259, 20, 'nonTechAreas', '0'),
(260, 20, 'declaration', '0'),
(261, 21, 'projects', '1'),
(262, 21, 'staffCosts', '1'),
(263, 21, 'epwCosts', '1'),
(264, 21, 'subcontractorCosts', '1'),
(265, 21, 'consumableCosts', '1'),
(266, 21, 'softwareCosts', '1'),
(267, 21, 'expenses', '1'),
(268, 21, 'commercialGoals', '1'),
(269, 21, 'aims', '1'),
(270, 21, 'difficulties', '1'),
(271, 21, 'technicalChallenges', '1'),
(272, 21, 'nonTechAreas', '1'),
(273, 21, 'declaration', '1'),
(274, 22, 'projects', '1'),
(275, 22, 'staffCosts', '1'),
(276, 22, 'epwCosts', '1'),
(277, 22, 'subcontractorCosts', '1'),
(278, 22, 'consumableCosts', '1'),
(279, 22, 'softwareCosts', '1'),
(280, 22, 'expenses', '1'),
(281, 22, 'commercialGoals', '1'),
(282, 22, 'aims', '1'),
(283, 22, 'difficulties', '1'),
(284, 22, 'technicalChallenges', '1'),
(285, 22, 'nonTechAreas', '1'),
(286, 22, 'declaration', '1'),
(287, 23, 'projects', '1'),
(288, 23, 'staffCosts', '1'),
(289, 23, 'epwCosts', '1'),
(290, 23, 'subcontractorCosts', '1'),
(291, 23, 'consumableCosts', '1'),
(292, 23, 'softwareCosts', '1'),
(293, 23, 'expenses', '1'),
(294, 23, 'commercialGoals', '1'),
(295, 23, 'aims', '1'),
(296, 23, 'difficulties', '1'),
(297, 23, 'technicalChallenges', '1'),
(298, 23, 'nonTechAreas', '1'),
(299, 23, 'declaration', '1'),
(313, 25, 'projects', '1'),
(314, 25, 'staffCosts', '1'),
(315, 25, 'epwCosts', '1'),
(316, 25, 'subcontractorCosts', '1'),
(317, 25, 'consumableCosts', '1'),
(318, 25, 'softwareCosts', '1'),
(319, 25, 'expenses', '1'),
(320, 25, 'commercialGoals', '1'),
(321, 25, 'aims', '1'),
(322, 25, 'difficulties', '1'),
(323, 25, 'technicalChallenges', '1'),
(324, 25, 'nonTechAreas', '1'),
(325, 25, 'declaration', '1'),
(352, 28, 'projects', '1'),
(353, 28, 'staffCosts', '1'),
(354, 28, 'epwCosts', '1'),
(355, 28, 'subcontractorCosts', '1'),
(356, 28, 'consumableCosts', '1'),
(357, 28, 'softwareCosts', '1'),
(358, 28, 'expenses', '1'),
(359, 28, 'commercialGoals', '1'),
(360, 28, 'aims', '1'),
(361, 28, 'difficulties', '1'),
(362, 28, 'technicalChallenges', '1'),
(363, 28, 'nonTechAreas', '1'),
(364, 28, 'declaration', '1'),
(430, 34, 'projects', '1'),
(431, 34, 'staffCosts', '1'),
(432, 34, 'epwCosts', '1'),
(433, 34, 'subcontractorCosts', '1'),
(434, 34, 'consumableCosts', '1'),
(435, 34, 'softwareCosts', '1'),
(436, 34, 'expenses', '1'),
(437, 34, 'commercialGoals', '1'),
(438, 34, 'aims', '1'),
(439, 34, 'difficulties', '1'),
(440, 34, 'technicalChallenges', '1'),
(441, 34, 'nonTechAreas', '1'),
(442, 34, 'declaration', '1'),
(469, 37, 'projects', '1'),
(470, 37, 'staffCosts', '1'),
(471, 37, 'epwCosts', '1'),
(472, 37, 'subcontractorCosts', '1'),
(473, 37, 'consumableCosts', '1'),
(474, 37, 'softwareCosts', '1'),
(475, 37, 'expenses', '1'),
(476, 37, 'commercialGoals', '1'),
(477, 37, 'aims', '1'),
(478, 37, 'difficulties', '1'),
(479, 37, 'technicalChallenges', '1'),
(480, 37, 'nonTechAreas', '1'),
(481, 37, 'declaration', '1'),
(482, 38, 'projects', '0'),
(483, 38, 'staffCosts', '1'),
(484, 38, 'epwCosts', '1'),
(485, 38, 'subcontractorCosts', '1'),
(486, 38, 'consumableCosts', '1'),
(487, 38, 'softwareCosts', '1'),
(488, 38, 'expenses', '1'),
(489, 38, 'commercialGoals', '0'),
(490, 38, 'aims', '0'),
(491, 38, 'difficulties', '0'),
(492, 38, 'technicalChallenges', '0'),
(493, 38, 'nonTechAreas', '0'),
(494, 38, 'declaration', '1'),
(495, 39, 'projects', '0'),
(496, 39, 'staffCosts', '1'),
(497, 39, 'epwCosts', '1'),
(498, 39, 'subcontractorCosts', '1'),
(499, 39, 'consumableCosts', '1'),
(500, 39, 'softwareCosts', '1'),
(501, 39, 'expenses', '1'),
(502, 39, 'commercialGoals', '0'),
(503, 39, 'aims', '0'),
(504, 39, 'difficulties', '0'),
(505, 39, 'technicalChallenges', '0'),
(506, 39, 'nonTechAreas', '0'),
(507, 39, 'declaration', '1');

-- --------------------------------------------------------

--
-- Table structure for table `company_projects`
--

CREATE TABLE `company_projects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `claim_id` int(11) NOT NULL,
  `project_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `project_status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `project_summary` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `company_projects`
--

INSERT INTO `company_projects` (`id`, `claim_id`, `project_type`, `project_status`, `project_summary`, `created_at`, `modified_at`) VALUES
(1, 1, 'New system', NULL, 'dgszxcvzxcv', '2020-08-06 14:17:57', NULL),
(2, 3, 'New products', 'approved', 'hjkjhk', '2020-08-07 08:02:26', NULL),
(3, 6, 'New processes', 'approved', 'safafsadfsdf', '2020-08-07 11:25:18', NULL),
(4, 9, 'New products', 'disapproved', 'sdfgsdfgsfgsg', '2020-08-07 12:25:33', NULL),
(5, 10, 'Scientific understanding', 'approved', 'sdfasdf sfsasdfcsd', '2020-08-07 13:23:37', '2020-08-10 04:53:47'),
(6, 14, 'New products', 'approved', 'Add all projects that required R&D for the financial Year in question. In the description, make sure to include details of the technical difficulties faced and how ROAD LTD worked towards resolving them', '2020-08-10 09:22:10', '2020-08-10 13:17:53'),
(7, 15, 'New products', 'approved', 'See email', '2020-09-09 09:51:09', NULL),
(8, 16, 'New products', 'approved', 'See email', '2020-09-09 09:57:37', NULL),
(9, 17, 'New products', 'approved', 'See profile email', '2020-09-10 08:27:23', NULL),
(10, 18, 'Advanced engineering', 'approved', 'Lots in emails dated 12/6 project 2', '2020-09-14 08:55:33', NULL),
(11, 19, 'CRM development/installation', 'approved', 'From Michael email', '2020-09-14 12:31:00', NULL),
(12, 19, 'Software coding', 'approved', 'Emil', '2020-09-14 12:31:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `consumable_costs`
--

CREATE TABLE `consumable_costs` (
  `cc_id` bigint(20) UNSIGNED NOT NULL,
  `claim_id` bigint(20) NOT NULL,
  `rm_total_amount` int(11) NOT NULL,
  `rm_per_attributed` int(11) NOT NULL,
  `utl_total_amount` int(11) NOT NULL,
  `utl_per_attributed` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `costs`
--

CREATE TABLE `costs` (
  `cost_id` bigint(20) UNSIGNED NOT NULL,
  `claim_id` int(11) NOT NULL,
  `expenditure` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `total_amount` int(11) NOT NULL,
  `per_attributed` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `costs`
--

INSERT INTO `costs` (`cost_id`, `claim_id`, `expenditure`, `total_amount`, `per_attributed`, `created_at`, `updated_at`) VALUES
(1, 3, 'raw-material', 11, 1, '2020-08-07 08:27:08', NULL),
(2, 3, 'utilities', 11, 1, '2020-08-07 08:27:12', NULL),
(3, 3, 'software', 123, 1, '2020-08-07 08:28:48', '2020-08-07 08:28:48'),
(4, 3, 'reimbursed', 123, 1, '2020-08-07 08:29:11', NULL),
(5, 1, 'raw-material', 2342342, 4, '2020-08-07 11:39:07', NULL),
(6, 1, 'utilities', 23423434, 9, '2020-08-07 11:39:09', NULL),
(7, 1, 'software', 324234234, 1, '2020-08-07 11:39:16', NULL),
(8, 1, 'reimbursed', 23422344, 1, '2020-08-07 11:39:20', NULL),
(9, 9, 'raw-material', 2147483647, 100, '2020-08-07 13:13:07', NULL),
(10, 9, 'raw-material', 2147483647, 100, '2020-08-07 13:13:07', NULL),
(11, 9, 'raw-material', 2147483647, 100, '2020-08-07 13:13:13', NULL),
(12, 9, 'raw-material', 2147483647, 100, '2020-08-07 13:13:14', NULL),
(13, 9, 'utilities', 2147483647, 100, '2020-08-07 13:13:16', NULL),
(14, 9, 'software', 3333333, 100, '2020-08-07 13:13:34', NULL),
(15, 9, 'reimbursed', 2345, 100, '2020-08-07 13:13:52', NULL),
(16, 10, 'raw-material', 44, 1, '2020-08-07 13:24:19', NULL),
(17, 10, 'utilities', 44, 1, '2020-08-07 13:24:21', NULL),
(18, 10, 'software', 44, 1, '2020-08-07 13:24:27', NULL),
(19, 10, 'reimbursed', 444, 1, '2020-08-07 13:24:35', NULL),
(20, 14, 'raw-material', 12, 1, '2020-08-10 09:27:08', NULL),
(21, 14, 'utilities', 14, 1, '2020-08-10 09:27:10', NULL),
(22, 14, 'software', 18, 1, '2020-08-10 09:27:18', NULL),
(23, 14, 'reimbursed', 22, 1, '2020-08-10 09:27:26', NULL),
(24, 15, 'raw-material', 1429762, 1, '2020-09-09 09:52:52', NULL),
(25, 15, 'utilities', 3182, 12, '2020-09-09 09:53:04', NULL),
(26, 15, 'software', 12354, 10, '2020-09-09 09:54:27', NULL),
(27, 15, 'reimbursed', 10566, 50, '2020-09-09 09:54:44', NULL),
(28, 16, 'utilities', 3418, 12, '2020-09-09 09:59:41', NULL),
(29, 16, 'raw-material', 1534232, 1, '2020-09-09 09:59:42', NULL),
(30, 16, 'software', 13817, 10, '2020-09-09 09:59:51', NULL),
(31, 16, 'reimbursed', 9247, 24, '2020-09-09 10:00:25', NULL),
(32, 17, 'raw-material', 88637, 14, '2020-09-10 08:29:57', NULL),
(33, 17, 'utilities', 2095, 20, '2020-09-10 08:30:12', NULL),
(34, 17, 'software', 1936, 20, '2020-09-10 08:30:23', NULL),
(35, 17, 'reimbursed', 2999, 31, '2020-09-10 08:30:53', NULL),
(36, 18, 'raw-material', 10368, 35, '2020-09-14 08:56:28', NULL),
(37, 18, 'utilities', 3211, 58, '2020-09-14 08:56:37', NULL),
(38, 18, 'software', 0, 0, '2020-09-14 08:56:42', '2020-09-14 08:56:45'),
(39, 18, 'reimbursed', 758, 32, '2020-09-14 08:57:25', NULL),
(40, 19, 'raw-material', 14625, 100, '2020-09-14 12:33:13', NULL),
(41, 19, 'utilities', 4635, 20, '2020-09-14 12:33:25', NULL),
(42, 19, 'software', 6190, 5, '2020-09-14 12:33:40', NULL),
(43, 19, 'reimbursed', 53363, 14, '2020-09-14 12:34:16', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `declaration`
--

CREATE TABLE `declaration` (
  `id` bigint(20) NOT NULL,
  `claim_id` bigint(20) NOT NULL,
  `signatureSrc` longtext NOT NULL,
  `signedBy` int(11) NOT NULL,
  `declaration` int(11) NOT NULL,
  `businessTerms` int(11) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `declaration`
--

INSERT INTO `declaration` (`id`, `claim_id`, `signatureSrc`, `signedBy`, `declaration`, `businessTerms`, `created_at`) VALUES
(1, 1, 'data:image/png;base64,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', 70, 1, 1, '2020-08-07 11:40:31'),
(2, 10, 'data:image/png;base64,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', 70, 1, 1, '2020-08-10 04:56:45'),
(3, 14, 'data:image/png;base64,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', 70, 1, 1, '2020-08-10 09:28:24'),
(4, 15, 'data:image/png;base64,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', 71, 1, 1, '2020-09-09 09:56:08');
INSERT INTO `declaration` (`id`, `claim_id`, `signatureSrc`, `signedBy`, `declaration`, `businessTerms`, `created_at`) VALUES
(5, 16, 'data:image/png;base64,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', 71, 1, 1, '2020-09-09 10:01:13'),
(6, 17, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAfQAAADICAYAAAAeGRPoAAAgAElEQVR4Xu2dCfx/1ZjHP5ZSobQoFKLFvmRrUZqxtFCihknZoywhabKPGUwRCclSZIlGMZZISphMtglRyS5CkYiQSWRenzq37v/+v/d7n+fcc+89997Peb1+r/h/n7O9z/1+n3vOeZYbQEUEREAEREAERGD0BG4w+hloAiIgAiIgAiIgApBC10MgAiIgAiIgAhMgIIU+gUXUFERABERABERACl3PgAiIgAiIgAhMgIAU+gQWUVMQAREQAREQASl0PQMiIAIiIAIiMAECUugTWERNQQREQAREQASk0PUMiIAIiIAIiMAECEihT2ARNQUREAEREAERkELXMyACIiACIiACEyAghT6BRdQUREAEREAEREAKXc+ACIiACIiACEyAgBT6BBZRUxABERABERABKfRhn4FbAngxgN0ArA3gMgBXA/gcgC8A+MCww1PvIiACIiACYyEghT7cSj0LwKEA1lwyhP8G8CYAHxtumOpZBERABERgDASk0IdZpX0BvMPR9S8APBzAOY46EhUBERABEZgRASn0/hd7PwBvj+z2VwA+DuAjAE6NbEPVREAEREAEJkhACr2/Rb0vgBMB3DFRl98G8GEA/O+HErWpZkRABERABEZKQAq9+4V7MoAnAfiHjruiUi/+Ou4KNOa7G4CLAHy/687UvgiIgAiIQDMBKfRmRrESVOAHAtg1toHIejyOPwzAVyPrV6vtBWBzANsDWBfAnQCsuqDtvwK4ceXffw/gD+Hun5b73wPwyUTjUjMiIAIiIAIlAlLo3TwOVOaf76Zpc6u0jj/ALH29IMfOv10A8JogdflduCb4KIDDUzeu9kRABERgrgSk0NOv/NkA7p2+2agWfwtgOwDnG2o/Mlje38ogm1KEx/bHADgLAHf5V5Yap9ueigiIgAiIgIGAFLoBkkPk7w7ZvkT/BuDVAP6tpsNtAbyqhzv+NvO9OPjr3xDA6qWGvh6O9It/OgMATwC+CaD6WZv+VVcEREAEsicghZ5uiagwX9GyuS8D2AzAei3bWVT9heFuvfzZ8QAe10FfuTTJEwr+fRAAj/i/kcvANA4REAERSE1ACj0N0bbK/CoAh5R20TRE498j0gzvulZ2Cv7rdw19PSZx+7k3d2HJj1/H+bmvlsYnAiLgIiCF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xnvnS0YupYi892YAx+UyKI1DBETAT0AKvZ4Z4zC/q+ZjKvtj/bhHX4MKihbPj3Bk5rJMmsaFDKwxlwxehbLnLp6nH3xZKIKKFD7HzJ2+hgVekCnizjP2PE8b6goD1DCfOX3LGaWuy6h0juFLVAREoC0BKfR6gluEDFyLflQfAOCstvAnUJ/+7dx9Mowoj7G5+6xmHKOiKVwArwz+s3T3466W4U4/LaViehIWxQEvnxKYGpGQCIjAdAlIoS9f20Ux0WUw1Px9UOCLZkaSEAEREIGkBKTQm3HuEAyymFKTObOZpUhFBERABERABLIiIIWe1XJoMCIgAiIgAiIQR0AKPY6baomACIiACIhAVgSk0LNaDg1GBERABERABOIISKHHcVMtERABERABEciKgBR6VsuhwYiACIiACIhAHAEp9DhuqiUCIiACIiACWRGQQs9qOTQYERABERABEYgjIIUex021REAEREAERCArAlLoWS2HBiMCIiACIiACcQSk0OO4qZYIiIAIiIAIZEVACj2r5dBgREAEREAERCCOgBR6HDfVEgEREAEREIGsCEihZ7UcGowIiIAIiIAIxBGQQo/jploiIAIiIAIikBUBKfSslkODEQEREAEREIE4AlLocdxUSwREQAREQASyIiCFntVyaDAiIAIiIAIiEEdACj2Om2qJgAiIgAiIQFYEpNCzWg4NRgREQAREQATiCEihx3FTLREQAREQARHIioAUelbLocGIgAiIgAiIQBwBKfQ4bqolAiIgAiIgAlkRkELPajk0GBEQAREQARGII/D/z3BqMhVS+SwAAAAASUVORK5CYII=', 71, 1, 1, '2020-09-15 09:23:32');

-- --------------------------------------------------------

--
-- Table structure for table `difficulties`
--

CREATE TABLE `difficulties` (
  `id` int(11) NOT NULL,
  `claim_id` bigint(20) NOT NULL,
  `isAccessible` int(11) DEFAULT '0',
  `isProtected` int(11) DEFAULT '0',
  `conflict` int(11) DEFAULT '0',
  `difficult` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `difficulties`
--

INSERT INTO `difficulties` (`id`, `claim_id`, `isAccessible`, `isProtected`, `conflict`, `difficult`, `created_at`) VALUES
(1, 3, 1, NULL, NULL, NULL, '2020-08-07 08:30:21'),
(2, 1, 1, 1, 1, 1, '2020-08-07 11:39:50'),
(3, 10, 1, 1, 1, 1, '2020-08-10 04:55:53'),
(4, 14, 1, 1, NULL, NULL, '2020-08-10 09:27:57'),
(5, 15, 1, NULL, NULL, 1, '2020-09-09 09:55:12'),
(6, 16, 1, NULL, NULL, 1, '2020-09-09 10:00:56'),
(7, 17, 1, NULL, NULL, 1, '2020-09-10 08:31:43'),
(8, 18, 1, NULL, NULL, 1, '2020-09-14 08:59:00'),
(9, 19, 1, NULL, NULL, 1, '2020-09-14 12:34:55');

-- --------------------------------------------------------

--
-- Table structure for table `email_template`
--

CREATE TABLE `email_template` (
  `email_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `email_template`
--

INSERT INTO `email_template` (`email_id`, `title`, `subject`, `body`, `created_at`, `updated_at`) VALUES
(1, 'Invite Submissions', 'Submission of R&D Tax Claim Invited Portal', '&#10;&#10;<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">&#10;&#9;<tbody>&#10;&#9;&#9;<tr>&#10;&#9;&#9;&#9;<td align=\"center\" valign=\"top\">&#10;&#9;&#9;&#9;<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">&#10;&#9;&#9;&#9;&#9;<tbody>&#10;&#9;&#9;&#9;&#9;&#9;<tr>&#10;&#9;&#9;&#9;&#9;&#9;&#9;<td>&#10;&#9;&#9;&#9;&#9;&#9;&#9;<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<tbody>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<tr>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<td>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<tbody>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<tr>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<td width=\"140\"><a href=\"#baseUrl#/\" target=\"_blank\"><img alt=\"BTC-logo\" src=\"http://35.178.231.49:8000/images/5d8cc6c00d8d0d20c2e296f81572618115032.png\"></a></td>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<td colspan=\"2\">&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<div>&#160;</div>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</td>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</tr>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</tbody>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</table>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</td>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</tr>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<tr>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<td>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<tbody>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<tr>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<td>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<h2>Dear #dearStr#,</h2>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</td>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</tr>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<tr>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<td>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<p><span>#inviteName#</span> has completed the R&amp;D tax credit claim of a <span>#companyName#</span> for period ending #endDate#.`</p>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</td>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</tr>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<tr>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<td>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<p>Kind Regards,</p>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</td>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</tr>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<tr>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<td>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<p>Business Tax Claims (Trading Style of Shephard &amp; Co)</p>&#10;&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<p>Tel: <strong>0161 425 0990</strong></p>&#10;&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<p>Freephone: <strong>0800 699 0765</strong></p>&#10;&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<p>Web: <a href=\"www.businesstaxclaims.com\" target=\"_blank\">www.businesstaxclaims.com</a></p>&#10;&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<p>Email: <a href=\"mailto:user.name@businesstaxclaims.com\">user.name@businesstaxclaims.com</a></p>&#10;&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<p><a href=\"#baseUrl#\"><img alt=\"BTC-logo\" src=\"http://35.178.231.49:8000/images/5d8cc6c00d8d0d20c2e296f81572618115032.png\"></a></p>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</td>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</tr>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<tr>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<td>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;<p>IMPORTANT: The contents of this email and any attachments are confidential. They are intended for the named recipient(s) only. If you have received this email by mistake, please notify the sender immediately and do not disclose the contents to anyone or make copies thereof. Please consider your environmental responsibility. Before printing this e-mail message, ask yourself whether you really need a hard copy.</p>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</td>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</tr>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</tbody>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</table>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</td>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</tr>&#10;&#9;&#9;&#9;&#9;&#9;&#9;&#9;</tbody>&#10;&#9;&#9;&#9;&#9;&#9;&#9;</table>&#10;&#9;&#9;&#9;&#9;&#9;&#9;</td>&#10;&#9;&#9;&#9;&#9;&#9;</tr>&#10;&#9;&#9;&#9;&#9;</tbody>&#10;&#9;&#9;&#9;</table>&#10;&#9;&#9;&#9;</td>&#10;&#9;&#9;</tr>&#10;&#9;</tbody>&#10;</table>', '2020-06-22 13:36:25', '0000-00-00 00:00:00'),
(2, 'Registration Email', 'Welcome to Business Tax Claims R&D Portal', '<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\n<title></title>\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n	<tbody>\n		<tr>\n			<td align=\"center\" valign=\"top\">\n			<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"max-width: 600px;\">\n				<tbody>\n					<tr>\n						<td>\n						<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width: 100%; border-style:solid;border-width:3px 1px 1px;border-color:#00a254 #dee2e6 #dee2e6; padding: 15px 30px;\">\n							<tbody>\n								<tr>\n									<td>\n									<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width: 100%;\">\n										<tbody>\n											<tr>\n												<td width=\"140\"><a href=\"#baseUrl#/\" style=\"display: inline-block;width: 140px;\" target=\"_blank\"><img alt=\"BTC-logo\" src=\"http://35.178.231.49:8000/images/5d8cc6c00d8d0d20c2e296f81572618115032.png\" style=\"width:100%;max-width:120px;height:auto;max-height:30px;\" /></a></td>\n												<td colspan=\"2\">\n												<div style=\"height: 1px;background: #e3e3e3;margin: 20px 0 0 8px\">&nbsp;</div>\n												</td>\n											</tr>\n										</tbody>\n									</table>\n									</td>\n								</tr>\n								<tr>\n									<td>\n									<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"width: 100%;\">\n										<tbody>\n											<tr>\n												<td>\n												<h2 style=\"font-size: 16px;color: #000;font-family: Arial, sans-serif;line-height: normal;margin-top: 35px;font-weight: 500;margin-bottom: 10px;\">Dear <span style=\"text-transform: capitalize;\">#dearStr#</span>,</h2>\n												</td>\n											</tr>\n											<tr>\n												<td>\n												<p style=\"font-family: Arial, sans-serif;font-size: 16px;color: #000;margin: 15px 0 0 0;\">Welcome to the Business Tax Claims R&amp;D Portal. Your account has been created successfully.</p>\n\n												<p style=\"font-family: Arial, sans-serif;font-size: 16px;color: #000;margin: 15px 0 0 0;\">Email: #email#<br />\n												Password: #password#</p>\n\n												<p style=\"font-family: Arial, sans-serif;font-size: 16px;color: #000;margin: 10px 0 0 0;line-height: 22px;\">Please click the button to go to portal</p>\n												</td>\n											</tr>\n											<tr>\n												<td style=\"text-align:center;\"><a href=\"#btnLink#\" style=\"font-family: Arial,sans-serif;display: inline-block;text-decoration: none;font-size: 14px;margin:35px 0;color: #fff;font-weight: 700;background-color: #00a254;border-radius:0;padding: 14px 25px;cursor: pointer;\">Go to Portal<img src=\"http://35.178.231.49:8000/images/right-arrow.png\" style=\"vertical-align: middle;\n                                                                    margin-left: 10px;\" /></a></td>\n											</tr>\n											<tr>\n												<td>\n												<p style=\"font-family: Arial, sans-serif;font-size: 13px;color: #000000;line-height: 17px;margin:20px 0 5px;\">Kind Regards,</p>\n												</td>\n											</tr>\n											<tr>\n												<td style=\"padding-top:5px;\">\n												<p style=\"font-family: Arial, sans-serif;font-size: 13px;color: #000000;line-height: 17px;margin:0 0 5px;\">Business Tax Claims (Trading Style of Shephard &amp; Co)</p>\n\n												<p style=\"font-family: Arial, sans-serif;font-size: 13px;color: #000000;line-height: 17px;margin:0 0 5px;\">Tel: <strong>0161 425 0990</strong></p>\n\n												<p style=\"font-family: Arial, sans-serif;font-size: 13px;color: #000000;line-height: 17px;margin:0 0 5px;\">Freephone: <strong>0800 699 0765</strong></p>\n\n												<p style=\"font-family: Arial, sans-serif;font-size: 13px;color: #000000;line-height: 17px;margin:0 0 5px;\">Web: <a href=\"www.businesstaxclaims.com\" style=\"color:#00a254;font-weight:bold;\" target=\"_blank\">www.businesstaxclaims.com</a></p>\n\n												<p style=\"font-family: Arial, sans-serif;font-size: 13px;color: #000000;line-height: 17px;margin:0 0 10px;\">Email: <a href=\"mailto:user.name@businesstaxclaims.com\" style=\"color:#00a254;font-weight:bold;\">user.name@businesstaxclaims.com</a></p>\n\n												<p><a href=\"#baseUrl#\" style=\"width:150px;display:inline-block;vertical-align:top;\"><img alt=\"BTC-logo\" src=\"http://35.178.231.49:8000/images/5d8cc6c00d8d0d20c2e296f81572618115032.png\" style=\"width:100%;max-width:120px;height:auto;max-height:30px;\" /></a></p>\n												</td>\n											</tr>\n											<tr>\n												<td style=\"padding-top:20px;\">\n												<p style=\"font-family: Arial, sans-serif;font-size: 9px;color: #000000;line-height: 17px;margin:0 0 5px;\">IMPORTANT: The contents of this email and any attachments are confidential. They are intended for the named recipient(s) only. If you have received this email by mistake, please notify the sender immediately and do not disclose the contents to anyone or make copies thereof. Please consider your environmental responsibility. Before printing this e-mail message, ask yourself whether you really need a hard copy.</p>\n												</td>\n											</tr>\n										</tbody>\n									</table>\n									</td>\n								</tr>\n							</tbody>\n						</table>\n						</td>\n					</tr>\n				</tbody>\n			</table>\n			</td>\n		</tr>\n	</tbody>\n</table>', '2020-06-22 13:40:23', NULL),
(3, 'Reset Password', 'Reset Password - Business Tax Claims', '&nbsp;\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\n<title></title>\n<table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\">\n	<tbody>\n		<tr>\n			<td valign=\"top\" align=\"center\">\n			<table style=\"max-width: 600px;\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\">\n				<tbody>\n					<tr>\n						<td>\n						<table style=\"width: 100%; border-style:solid;border-width:3px 1px 1px;border-color:#00a254 #dee2e6 #dee2e6; padding: 15px 30px;\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\">\n							<tbody>\n								<tr>\n									<td>\n									<table style=\"width: 100%;\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\">\n										<tbody>\n											<tr>\n												<td width=\"140\"><a href=\"#baseUrl#/\" style=\"display: inline-block;width: 140px;\" target=\"_blank\"><img alt=\"BTC-logo\" src=\"\n#logo#\n\" style=\"width:100%;max-width:120px;height:auto;max-height:30px;\"></a></td>\n												<td colspan=\"2\">\n												<div style=\"height: 1px;background: #e3e3e3;margin: 20px 0 0 8px\">&nbsp;</div>\n												</td>\n											</tr>\n										</tbody>\n									</table>\n									</td>\n								</tr>\n								<tr>\n									<td>\n									<table style=\"width: 100%;\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\">\n										<tbody>\n											<tr>\n												<td>\n												<h2 style=\"font-size:16px;color: #000;font-family: Arial, sans-serif;line-height: normal;margin-top: 35px;font-weight: 500;margin-bottom: 10px;\">Dear #dearStr#,</h2>\n												</td>\n											</tr>\n											<tr>\n												<td>\n												<p style=\"font-family: Arial, sans-serif;font-size: 16px;color: #000;margin: 15px 0 20px;\">There has been a request to reset your password. Please click the button below to reset password:</p>\n												</td>\n											</tr>\n											<tr>\n												<td style=\"text-align:center;\"><a href=\"#btnLink#\" style=\"font-family: Arial,sans-serif;display: inline-block;text-decoration: none;font-size: 14px;margin:35px 0;color: #fff;font-weight: 700;background-color: #00a254;border-radius:0;padding: 14px 25px;cursor: pointer;\">Reset Password</a></td>\n											</tr>\n											<tr>\n												<td>\n												<p style=\"font-family: Arial, sans-serif;font-size: 16px;color: #000;margin: 10px 0 20px;\">If you didn’t mean to reset your password, then you can just ignore this email, your password will not be changed.</p>\n												</td>\n											</tr>\n											<tr>\n												<td>\n												<p style=\"font-family: Arial, sans-serif;font-size: 13px;color: #000000;line-height: 17px;margin:20px 0 5px;\">Kind Regards,</p>\n												</td>\n											</tr>\n											<tr>\n												<td style=\"padding-top:5px;\">\n												<p style=\"font-family: Arial, sans-serif;font-size: 13px;color: #000000;line-height: 17px;margin:0 0 5px;\">Business Tax Claims (Trading Style of Shephard &amp; Co)</p>\n\n												<p style=\"font-family: Arial, sans-serif;font-size: 13px;color: #000000;line-height: 17px;margin:0 0 5px;\">Tel: <strong>0161 425 0990</strong></p>\n\n												<p style=\"font-family: Arial, sans-serif;font-size: 13px;color: #000000;line-height: 17px;margin:0 0 5px;\">Freephone: <strong>0800 699 0765</strong></p>\n\n												<p style=\"font-family: Arial, sans-serif;font-size: 13px;color: #000000;line-height: 17px;margin:0 0 5px;\">Web: <a href=\"www.businesstaxclaims.com\" style=\"color:#00a254;font-weight:bold;\" target=\"_blank\">www.businesstaxclaims.com</a></p>\n\n												<p style=\"font-family: Arial, sans-serif;font-size: 13px;color: #000000;line-height: 17px;margin:0 0 10px;\">Email: <a href=\"mailto:user.name@businesstaxclaims.com\" style=\"color:#00a254;font-weight:bold;\">user.name@businesstaxclaims.com</a></p>\n												</td>\n											</tr>\n											<tr>\n												<td style=\"padding-top:20px;\">\n												<p><a href=\"#baseUrl#\" style=\"width:150px;display:inline-block;vertical-align:top;\"><img alt=\"BTC-logo\" width=120 src=\"#logo#\"></a></p>\n												</td>\n											</tr>\n											<tr>\n												<td style=\"padding-top:20px;\">\n												<p style=\"font-family: Arial, sans-serif;font-size: 9px;color: #000000;line-height: 17px;margin:0 0 5px;\">IMPORTANT: The contents of this email and any attachments are confidential. They are intended for the named recipient(s) only. If you have received this email by mistake, please notify the sender immediately and do not disclose the contents to anyone or make copies thereof. Please consider your environmental responsibility. Before printing this e-mail message, ask yourself whether you really need a hard copy.</p>\n												</td>\n											</tr>\n										</tbody>\n									</table>\n									</td>\n								</tr>\n							</tbody>\n						</table>\n						</td>\n					</tr>\n				</tbody>\n			</table>\n			</td>\n		</tr>\n	</tbody>\n</table>', '2020-06-22 13:41:10', '0000-00-00 00:00:00'),
(4, 'Send Invite', 'Business Tax Claims R&D Portal Invite', '&nbsp;\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\n<title></title>\n<table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\">\n	<tbody>\n		<tr>\n			<td valign=\"top\" align=\"center\">\n			<table style=\"max-width: 600px;\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\">\n				<tbody>\n					<tr>\n						<td>\n						<table style=\"width: 100%; border-style:solid;border-width:3px 1px 1px;border-color:#00a254 #dee2e6 #dee2e6; padding: 15px 30px;\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\">\n							<tbody>\n								<tr>\n									<td>\n									<table style=\"width: 100%;\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\">\n										<tbody>\n											<tr>\n												<td width=\"140\"><a href=\"#baseUrl#/\" style=\"display: inline-block;width: 140px;\" target=\"_blank\"><img alt=\"BTC-logo\" src=\"#logo#\" style=\"width:100%;max-width:120px;height:auto;max-height:30px;\"></a></td>\n												<td colspan=\"2\">\n												<div style=\"height: 1px;background: #e3e3e3;margin: 20px 0 0 8px\">&nbsp;</div>\n												</td>\n											</tr>\n										</tbody>\n									</table>\n									</td>\n								</tr>\n								<tr>\n									<td>\n									<table style=\"width: 100%;\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\">\n										<tbody>\n											<tr>\n												<td>\n												<h2 style=\"font-size: 16px;color: #000;font-family: Arial, sans-serif;line-height: normal;margin-top: 35px;font-weight: 500;margin-bottom: 10px; text-transform: capitalize;\">Dear #dearStr#,</h2>\n												</td>\n											</tr>\n											<tr>\n												<td>\n												<p style=\"font-family: Arial, sans-serif;font-size: 16px;color: #000;margin: 15px 0 0 0;\">I have invited you to use our portal to help complete your R&amp;D tax credit claim for period ending #endDate#.</p>\n\n												<p style=\"font-family: Arial, sans-serif;font-size: 16px;color: #000;margin: 10px 0 0 0;line-height: 22px;\">Please click the button to go to portal.</p>\n												</td>\n											</tr>\n											<tr>\n												<td style=\"text-align:center;\"><a href=\"#btnLink#\" style=\"font-family: Arial,sans-serif;display: inline-block;text-decoration: none;font-size: 14px;margin:35px 0;color: #fff;font-weight: 700;background-color: #00a254;border-radius:0;padding: 14px 25px;cursor: pointer;\">Go to portal</a></td>\n											</tr>\n											<tr>\n												<td>\n												<p style=\"font-family: Arial, sans-serif;font-size: 16px;color: #000;margin: 10px 0;\">Once you\'ve completed the invited sections, we will get a notification and will verify the information.</p>\n\n												<p style=\"font-family: Arial, sans-serif;font-size: 16px;color: #000;margin: 10px 0;\">Should you have any questions about this email, please let us&nbsp;know.</p>\n\n												<p style=\"font-family: Arial, sans-serif;font-size: 13px;color: #000000;line-height: 17px;margin:20px 0 5px;\">Kind Regards,</p>\n												</td>\n											</tr>\n											<tr>\n												<td style=\"padding-top:5px;\">\n												<p style=\"font-family: Arial, sans-serif;font-size: 13px;color: #000000;line-height: 17px;margin:0 0 5px;\">Business Tax Claims (Trading Style of Shephard &amp; Co)</p>\n\n												<p style=\"font-family: Arial, sans-serif;font-size: 13px;color: #000000;line-height: 17px;margin:0 0 5px;\">Tel: <strong><a href=\"tel:0161 425 0990\">0161 425 0990</a></strong></p>\n\n												<p style=\"font-family: Arial, sans-serif;font-size: 13px;color: #000000;line-height: 17px;margin:0 0 5px;\">Freephone: <strong><a href=\"tel:0800 699 0765\">0800 699 0765</a></strong></p>\n\n												<p style=\"font-family: Arial, sans-serif;font-size: 13px;color: #000000;line-height: 17px;margin:0 0 5px;\">Web: <a href=\"www.businesstaxclaims.com\" style=\"color:#00a254;font-weight:bold;\" target=\"_blank\">www.businesstaxclaims.com</a></p>\n\n												<p style=\"font-family: Arial, sans-serif;font-size: 13px;color: #000000;line-height: 17px;margin:0 0 10px;\">&nbsp;</p>\n\n												<p><a href=\"#baseUrl#\" style=\"width:150px;display:inline-block;vertical-align:top;\"><img width=120 alt=\"BTC-logo\" src=\"#logo#\"></a></p>\n												</td>\n											</tr>\n											<tr>\n												<td style=\"padding-top:20px;\">\n												<p style=\"font-family: Arial, sans-serif;font-size: 9px;color: #000000;line-height: 17px;margin:0 0 5px;\">IMPORTANT: The contents of this email and any attachments are confidential. They are intended for the named recipient(s) only. If you have received this email by mistake, please notify the sender immediately and do not disclose the contents to anyone or make copies thereof. Please consider your environmental responsibility. Before printing this e-mail message, ask yourself whether you really need a hard copy.</p>\n												</td>\n											</tr>\n										</tbody>\n									</table>\n									</td>\n								</tr>\n							</tbody>\n						</table>\n						</td>\n					</tr>\n				</tbody>\n			</table>\n			</td>\n		</tr>\n	</tbody>\n</table>', '2020-06-22 13:41:52', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `epw_costs`
--

CREATE TABLE `epw_costs` (
  `epw_id` bigint(20) UNSIGNED NOT NULL,
  `claim_id` int(11) NOT NULL,
  `staff_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `yearly_salary` int(11) NOT NULL,
  `per_R_D` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `epw_costs`
--

INSERT INTO `epw_costs` (`epw_id`, `claim_id`, `staff_name`, `yearly_salary`, `per_R_D`, `created_at`, `updated_at`) VALUES
(1, 9, 'Rest fiorm', 555, 100, '2020-08-07 12:29:37', NULL),
(2, 14, 'Four threst', 18000, 10, '2020-08-10 09:24:47', NULL),
(3, 14, 'Fivethought', 20000, 10, '2020-08-10 09:25:12', NULL),
(4, 14, 'sixteen', 22000, 10, '2020-08-10 09:25:34', NULL),
(5, 15, 'No EPWs', 0, 0, '2020-09-09 09:52:08', NULL),
(6, 16, 'No EPWs', 0, 0, '2020-09-09 09:58:37', NULL),
(7, 17, 'No EPWs', 0, 0, '2020-09-10 08:29:26', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8_unicode_ci NOT NULL,
  `queue` text COLLATE utf8_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2020_06_05_073217_create_roles_table', 1),
(5, '2020_06_05_073414_create_user_roles_table', 1),
(6, '2020_06_05_084215_create_roles_permission_table', 1),
(9, '2020_06_09_085132_create_client_company_table', 2),
(10, '2020_06_11_045031_create_cms_table', 3),
(11, '2020_06_15_113222_create_case_notes_table', 4),
(13, '2020_06_16_052232_create_company_claims', 6),
(14, '2020_06_15_131815_create_company_invites_tables', 7),
(15, '2020_06_18_060930_create_claim_projects', 8),
(16, '2020_06_18_130113_create_staff_costs', 8),
(18, '2020_06_19_053852_company_about', 9),
(19, '2020_06_19_074139_create_epw_costs', 10),
(20, '2020_06_19_113937_create_subcontractors_costs', 11),
(21, '2020_06_19_124758_create_consumable_costs_table', 12),
(22, '2020_06_19_131309_create_costs_table', 13),
(23, '2020_06_22_130230_create_email_template_table', 14);

-- --------------------------------------------------------

--
-- Table structure for table `non_tech_area`
--

CREATE TABLE `non_tech_area` (
  `id` bigint(20) NOT NULL,
  `claim_id` bigint(20) NOT NULL,
  `contracts` int(11) DEFAULT '0',
  `devDiaries` int(11) DEFAULT '0',
  `docsResults` int(11) DEFAULT '0',
  `invoices` int(11) DEFAULT '0',
  `projectPlans` int(11) DEFAULT '0',
  `prototypes` int(11) DEFAULT '0',
  `relatedFiles` int(11) DEFAULT '0',
  `relevantEmails` int(11) DEFAULT '0',
  `sprintPlan` int(11) DEFAULT '0',
  `timeSheets` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `non_tech_area`
--

INSERT INTO `non_tech_area` (`id`, `claim_id`, `contracts`, `devDiaries`, `docsResults`, `invoices`, `projectPlans`, `prototypes`, `relatedFiles`, `relevantEmails`, `sprintPlan`, `timeSheets`, `created_at`) VALUES
(1, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2020-08-07 11:40:03'),
(2, 10, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2020-08-10 04:56:20'),
(3, 14, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2020-08-10 09:28:15'),
(4, 15, NULL, NULL, 1, NULL, 1, 1, NULL, 1, NULL, NULL, '2020-09-09 09:55:42'),
(5, 16, NULL, NULL, 1, NULL, NULL, 1, NULL, 1, NULL, NULL, '2020-09-09 10:01:06'),
(6, 17, NULL, NULL, 1, NULL, 1, 1, NULL, 1, NULL, NULL, '2020-09-10 08:32:00'),
(7, 18, NULL, NULL, 1, NULL, 1, 1, 1, 1, NULL, NULL, '2020-09-14 08:59:36'),
(8, 19, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, '2020-09-14 12:35:19');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('democoder3535@gmail.com', 'eHQSjtwaxPXMw92SC6qBQokPSnrW1qj0Iul523qwXcAh7XeLZ3WZgq4F5rKY', '2020-08-07 07:51:37'),
('democoder3535@gmail.com', 'x59Cba6tcdsyxDkhYlYYX1vHU97LqI3tE6dIgsFaV1N8BeBI4RHP1PihIOyE', '2020-08-07 07:54:08');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` bigint(20) NOT NULL,
  `claim_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`id`, `claim_id`, `created_at`, `status`) VALUES
(1, 1, '2020-08-07 11:40:48', '0'),
(3, 10, '2020-08-10 06:21:54', '0');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `editable` int(11) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role_name`, `editable`, `created_at`, `updated_at`) VALUES
(1, 'admin', 1, '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(2, 'manager', 0, '2020-06-24 10:20:26', '2020-08-07 12:06:34');

-- --------------------------------------------------------

--
-- Table structure for table `roles_permission`
--

CREATE TABLE `roles_permission` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` int(11) NOT NULL,
  `permission_key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permission_value` bit(1) NOT NULL COMMENT 'true:show,false:not',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `roles_permission`
--

INSERT INTO `roles_permission` (`id`, `role_id`, `permission_key`, `permission_value`, `created_at`, `updated_at`) VALUES
(1, 1, 'showRole', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(2, 1, 'addRole', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(3, 1, 'editRole', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(4, 1, 'deleteRole', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(5, 1, 'showUser', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(6, 1, 'addUser', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(7, 1, 'editUser', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(8, 1, 'deleteUser', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(9, 1, 'showReports', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(10, 1, 'editReport', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(11, 1, 'deleteReport', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(12, 1, 'reviewReport', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(13, 1, 'downloadReport', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(14, 1, 'changeReportStatus', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(15, 1, 'showClients', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(16, 1, 'addClient', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(17, 1, 'searchClient', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(18, 1, 'viewCaseNotes', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(19, 1, 'showClaims', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(20, 1, 'addClaim', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(21, 1, 'editClaim', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(22, 1, 'reviewClaim', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(23, 1, 'downloadClaim', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(24, 1, 'printClaim', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(25, 1, 'exportClaimCSV', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(26, 1, 'showCMS', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(27, 1, 'addCMS', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(28, 1, 'editCMS', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(29, 1, 'deleteCMS', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(30, 1, 'changeProjectStatus', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(31, 1, 'settings', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(32, 1, 'siteSettings', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(33, 1, 'showTemplates', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(34, 1, 'editTemplate', b'1', '2020-06-24 10:19:57', '2020-06-24 10:22:16'),
(35, 2, 'showRole', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(36, 2, 'addRole', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(37, 2, 'editRole', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(38, 2, 'deleteRole', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(39, 2, 'showUser', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(40, 2, 'addUser', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(41, 2, 'editUser', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(42, 2, 'deleteUser', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(43, 2, 'showReports', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(44, 2, 'editReport', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(45, 2, 'deleteReport', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(46, 2, 'reviewReport', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(47, 2, 'downloadReport', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(48, 2, 'changeReportStatus', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(49, 2, 'showClients', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(50, 2, 'addClient', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(51, 2, 'searchClient', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(52, 2, 'viewCaseNotes', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(53, 2, 'showClaims', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(54, 2, 'addClaim', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(55, 2, 'editClaim', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(56, 2, 'reviewClaim', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(57, 2, 'downloadClaim', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(58, 2, 'printClaim', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(59, 2, 'exportClaimCSV', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(60, 2, 'showCMS', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(61, 2, 'addCMS', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(62, 2, 'editCMS', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(63, 2, 'deleteCMS', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(64, 2, 'changeProjectStatus', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(65, 2, 'settings', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(66, 2, 'siteSettings', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(67, 2, 'showTemplates', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34'),
(68, 2, 'editTemplate', b'1', '2020-06-24 10:20:26', '2020-08-07 12:06:34');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `meta_title` varchar(150) NOT NULL,
  `meta_description` text NOT NULL,
  `meta_tags` text NOT NULL,
  `logo` text NOT NULL,
  `favicon` text NOT NULL,
  `powered_by` text NOT NULL,
  `epw_cost` double NOT NULL,
  `email_from` varchar(150) NOT NULL,
  `password` varchar(150) NOT NULL,
  `email_service` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `title`, `meta_title`, `meta_description`, `meta_tags`, `logo`, `favicon`, `powered_by`, `epw_cost`, `email_from`, `password`, `email_service`) VALUES
(1, 'Business Tax Claims', 'BTC CRM ', 'Business Tax Claims ', 'btc,crm,tax,claims,clients', 'logo9ab46b81e48cf145f6d5c9935e442c0b0de111b5.png', 'favicon044628b370300f101f914df545a0a79750c995fc.png', 'powered_by04815ed2152187679a4e32e43e93c9e4a0d462cc.png', 0.65, 'info@creditool.co.uk', '', 'gmail');

-- --------------------------------------------------------

--
-- Table structure for table `staff_costs`
--

CREATE TABLE `staff_costs` (
  `costs_id` bigint(20) UNSIGNED NOT NULL,
  `claim_id` int(11) NOT NULL,
  `staff_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `yearly_salary` int(11) NOT NULL,
  `per_R_D` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `staff_costs`
--

INSERT INTO `staff_costs` (`costs_id`, `claim_id`, `staff_name`, `yearly_salary`, `per_R_D`, `created_at`, `updated_at`) VALUES
(1, 1, 'sdsdf', 333, 17, '2020-08-06 14:18:16', NULL),
(2, 9, 'Rest', 3400, 9, '2020-08-07 12:28:43', NULL),
(3, 14, 'Trasdf huston mile', 12000, 100, '2020-08-10 09:22:52', NULL),
(4, 14, 'fogter lime', 14000, 10, '2020-08-10 09:23:26', '2020-08-10 09:24:03'),
(5, 14, 'MemberThree', 14000, 10, '2020-08-10 09:23:50', '2020-08-10 09:24:11'),
(6, 14, 'Testnamet', 123456, 10, '2020-08-12 12:23:08', NULL),
(8, 14, 'Testnamet', 123456, 10, '2020-08-12 13:05:32', NULL),
(9, 14, 'Testnamet33', 123456, 20, '2020-08-12 13:08:45', NULL),
(10, 14, 'Testnamet33', 123456, 20, '2020-08-12 13:13:07', NULL),
(11, 15, 'Staff', 325488, 12, '2020-09-09 09:51:39', NULL),
(12, 15, 'Directors', 26800, 20, '2020-09-09 09:51:55', NULL),
(13, 16, 'Staff', 371423, 12, '2020-09-09 09:58:07', NULL),
(14, 16, 'Directors', 21200, 20, '2020-09-09 09:58:25', NULL),
(15, 17, 'Staff Costs', 49184, 20, '2020-09-10 08:28:28', NULL),
(16, 17, 'Directors', 6825, 25, '2020-09-10 08:29:09', NULL),
(17, 18, 'Staff costs', 45114, 58, '2020-09-14 08:56:00', NULL),
(18, 19, 'Staff', 191662, 20, '2020-09-14 12:31:44', NULL),
(19, 19, 'Directors', 16656, 30, '2020-09-14 12:32:03', '2020-09-14 12:32:16');

-- --------------------------------------------------------

--
-- Table structure for table `subcontractors_costs`
--

CREATE TABLE `subcontractors_costs` (
  `sc_id` bigint(20) UNSIGNED NOT NULL,
  `claim_id` int(11) NOT NULL,
  `total_amount` int(11) NOT NULL,
  `per_attributed` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `subcontractors_costs`
--

INSERT INTO `subcontractors_costs` (`sc_id`, `claim_id`, `total_amount`, `per_attributed`, `description`, `created_at`, `updated_at`) VALUES
(1, 14, 200000, 1, 'Trust Subcontractors Description', '2020-08-10 09:26:16', NULL),
(2, 14, 400000, 1, 'Subcontractors Description * Two', '2020-08-10 09:26:51', NULL),
(3, 15, 1100, 100, 'Sub contractor', '2020-09-09 09:52:42', NULL),
(4, 16, 517, 100, 'Sub contractor', '2020-09-09 09:58:59', NULL),
(5, 17, 0, 0, 'No sub contractors', '2020-09-10 08:29:43', NULL),
(6, 19, 32621, 100, 'Various sub contractors used for R&D projects', '2020-09-14 12:32:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `technical_challenge`
--

CREATE TABLE `technical_challenge` (
  `id` bigint(20) NOT NULL,
  `claim_id` bigint(20) NOT NULL,
  `software` text,
  `manufacture` text,
  `material` text,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `technical_challenge`
--

INSERT INTO `technical_challenge` (`id`, `claim_id`, `software`, `manufacture`, `material`, `created_at`) VALUES
(1, 2, 'trying to find and diagnose technical issues', NULL, NULL, '2020-08-07 09:56:46'),
(2, 1, 'trying to find and diagnose technical issues', 'finding non standard ways of reducing waste during the production process', 'trying to overcome the difficulties in using several materials to make one', '2020-08-07 11:39:57'),
(3, 10, 'trying to find and diagnose technical issues', 'scaling, where techniques that worked on a small scale did not work when scaled up', 'trying to overcome the difficulties in designing the composition of new materials', '2020-08-10 04:56:03'),
(4, 14, 'trying to find and diagnose technical issues', 'trying to find ways of automating jobs done by people where no machinery existed', 'trying to overcome the difficulties in the fabrication or manufacture of a new material', '2020-08-10 09:28:06'),
(5, 15, NULL, 'trying to find ways of automating jobs done by people where no machinery existed', 'trying to overcome the difficulties in using several materials to make one', '2020-09-09 09:55:38'),
(6, 16, NULL, 'improving product accuracy', 'trying to overcome the difficulties in using several materials to make one', '2020-09-09 10:01:02'),
(7, 17, NULL, 'developing reverse engineering techniques', 'trying to overcome the difficulties in using several materials to make one', '2020-09-10 08:31:56'),
(8, 18, NULL, 'trying to find ways of automating jobs done by people where no machinery existed', 'trying to overcome the difficulties in the fabrication or manufacture of a new material', '2020-09-14 08:59:23'),
(9, 19, 'trying to integrate technologies that the systems were not initially designed for', 'improving product accuracy', NULL, '2020-09-14 12:35:13');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` int(11) NOT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT '''''',
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `api_token` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `parent_id`, `first_name`, `last_name`, `email`, `phone`, `email_verified_at`, `password`, `api_token`, `remember_token`, `status`, `created_at`, `updated_at`) VALUES
(70, 0, 'Andrew', 'Chew', 'andrew.chew@businesstaxclaims.com', NULL, NULL, '$2y$10$2HiyIEKBOi8GduMBLPMOV.iUibxkwoeE1PkzR8brAsccVR.gaSsDS', '34149ece656d88356a0c5e0b6668c5fdacf3c398', NULL, 1, '2020-08-06 13:24:09', NULL),
(71, 0, 'Mark', 'Law', 'mark.law@businesstaxclaims.com', NULL, NULL, '$2y$10$kexeCIKyWpl32sneKu9yzOB9GSAyel0yZvaX4iyAt.1sfZLx0B0De', '2bce303a6c0938e7f56f7201669c417390c8e9ac', NULL, 1, '2020-08-06 13:26:50', NULL),
(73, 0, 'demo', 'coder', 'democoder3535@gmail.com', NULL, NULL, '$2y$10$T2PymK888rI/GBifBjS1xOzRtXBoutQ1E4SJf8ddA0ORzzxLGE4Cu', 'bf4560de791a08564fe586cac605c4bdf2665a45', NULL, 1, '2020-08-07 07:50:42', NULL),
(74, 0, 'web', 'tester', 'webtester0722@gmail.com', NULL, NULL, '$2y$10$T9fM7eNZzVHJKrbjcn6WoeWO/9wksqMtvLgxmC0t6QbxsSdJyX4NG', 'c494a96699097bbc5f2b016ddf07e00ef4497c5c', NULL, 1, '2020-08-07 12:55:27', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`id`, `user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(50, 70, 1, '2020-08-06 13:24:09', NULL),
(51, 71, 1, '2020-08-06 13:26:50', NULL),
(53, 73, 2, '2020-08-07 07:50:42', NULL),
(54, 74, 2, '2020-08-07 12:55:27', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aims`
--
ALTER TABLE `aims`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `case_notes`
--
ALTER TABLE `case_notes`
  ADD PRIMARY KEY (`case_id`);

--
-- Indexes for table `claims`
--
ALTER TABLE `claims`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`);

--
-- Indexes for table `client_company`
--
ALTER TABLE `client_company`
  ADD PRIMARY KEY (`company_id`),
  ADD UNIQUE KEY `client_company_email_unique` (`email`);

--
-- Indexes for table `cms`
--
ALTER TABLE `cms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cms_slug` (`cms_slug`);

--
-- Indexes for table `commercial_goals`
--
ALTER TABLE `commercial_goals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `company_about`
--
ALTER TABLE `company_about`
  ADD PRIMARY KEY (`about_id`);

--
-- Indexes for table `company_claims`
--
ALTER TABLE `company_claims`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `claim_id` (`claim_id`);

--
-- Indexes for table `company_invites`
--
ALTER TABLE `company_invites`
  ADD PRIMARY KEY (`invite_id`);

--
-- Indexes for table `company_invite_permissions`
--
ALTER TABLE `company_invite_permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `company_projects`
--
ALTER TABLE `company_projects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `consumable_costs`
--
ALTER TABLE `consumable_costs`
  ADD PRIMARY KEY (`cc_id`),
  ADD KEY `claim_id` (`claim_id`);

--
-- Indexes for table `costs`
--
ALTER TABLE `costs`
  ADD PRIMARY KEY (`cost_id`);

--
-- Indexes for table `declaration`
--
ALTER TABLE `declaration`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `difficulties`
--
ALTER TABLE `difficulties`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `email_template`
--
ALTER TABLE `email_template`
  ADD PRIMARY KEY (`email_id`);

--
-- Indexes for table `epw_costs`
--
ALTER TABLE `epw_costs`
  ADD PRIMARY KEY (`epw_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `non_tech_area`
--
ALTER TABLE `non_tech_area`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles_permission`
--
ALTER TABLE `roles_permission`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staff_costs`
--
ALTER TABLE `staff_costs`
  ADD PRIMARY KEY (`costs_id`);

--
-- Indexes for table `subcontractors_costs`
--
ALTER TABLE `subcontractors_costs`
  ADD PRIMARY KEY (`sc_id`);

--
-- Indexes for table `technical_challenge`
--
ALTER TABLE `technical_challenge`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_api_token_unique` (`api_token`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aims`
--
ALTER TABLE `aims`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `case_notes`
--
ALTER TABLE `case_notes`
  MODIFY `case_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `claims`
--
ALTER TABLE `claims`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `client_company`
--
ALTER TABLE `client_company`
  MODIFY `company_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `cms`
--
ALTER TABLE `cms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT for table `commercial_goals`
--
ALTER TABLE `commercial_goals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `company_about`
--
ALTER TABLE `company_about`
  MODIFY `about_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;
--
-- AUTO_INCREMENT for table `company_claims`
--
ALTER TABLE `company_claims`
  MODIFY `cid` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;
--
-- AUTO_INCREMENT for table `company_invites`
--
ALTER TABLE `company_invites`
  MODIFY `invite_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT for table `company_invite_permissions`
--
ALTER TABLE `company_invite_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=508;
--
-- AUTO_INCREMENT for table `company_projects`
--
ALTER TABLE `company_projects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `consumable_costs`
--
ALTER TABLE `consumable_costs`
  MODIFY `cc_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `costs`
--
ALTER TABLE `costs`
  MODIFY `cost_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;
--
-- AUTO_INCREMENT for table `declaration`
--
ALTER TABLE `declaration`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `difficulties`
--
ALTER TABLE `difficulties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `email_template`
--
ALTER TABLE `email_template`
  MODIFY `email_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `epw_costs`
--
ALTER TABLE `epw_costs`
  MODIFY `epw_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `non_tech_area`
--
ALTER TABLE `non_tech_area`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `roles_permission`
--
ALTER TABLE `roles_permission`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1014;
--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `staff_costs`
--
ALTER TABLE `staff_costs`
  MODIFY `costs_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `subcontractors_costs`
--
ALTER TABLE `subcontractors_costs`
  MODIFY `sc_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `technical_challenge`
--
ALTER TABLE `technical_challenge`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;
--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `claims`
--
ALTER TABLE `claims`
  ADD CONSTRAINT `claims_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `client_company` (`company_id`) ON DELETE NO ACTION;

--
-- Constraints for table `consumable_costs`
--
ALTER TABLE `consumable_costs`
  ADD CONSTRAINT `consumable_costs_ibfk_1` FOREIGN KEY (`claim_id`) REFERENCES `claims` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
