-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Client :  db:3306
-- Généré le :  Ven 03 Mars 2017 à 15:09
-- Version du serveur :  5.7.16
-- Version de PHP :  7.0.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `symfony`
--

-- --------------------------------------------------------

--
-- Structure de la table `authors`
--

CREATE TABLE `authors` (
  `id` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city_born_id` int(11) DEFAULT NULL,
  `city_died_id` int(11) DEFAULT NULL,
  `era_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `born` int(11) DEFAULT NULL,
  `born_range` smallint(6) DEFAULT NULL,
  `died` int(11) DEFAULT NULL,
  `died_range` smallint(6) DEFAULT NULL,
  `activity` smallint(6) DEFAULT NULL,
  `activity_range` smallint(6) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `authors`
--

INSERT INTO `authors` (`id`, `name`, `city_born_id`, `city_died_id`, `era_id`, `user_id`, `group_id`, `born`, `born_range`, `died`, `died_range`, `activity`, `activity_range`, `deleted_at`, `created_at`, `updated_at`) VALUES
(9, 'callimachus', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 'meleager', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 'meleager', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 'anonymi epigrammatici', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 'anonymi epigrammatici', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `authors_authority`
--

CREATE TABLE `authors_authority` (
  `id_author_authority` int(11) NOT NULL,
  `id_author` int(11) NOT NULL,
  `URI` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `authors_authority`
--

INSERT INTO `authors_authority` (`id_author_authority`, `id_author`, `URI`) VALUES
(1, 9, 'http://catalog.perseus.org/catalog/urn:cts:greekLit:tlg-0533'),
(2, 10, 'http://catalog.perseus.org/catalog/urn:cts:greekLit:tlg-1492'),
(3, 11, 'http://catalog.perseus.org/catalog/urn:cts:greekLit:tlg-1492'),
(4, 12, 'http://catalog.perseus.org/catalog/urn:cts:greekLit:tlg-0138'),
(5, 13, 'http://catalog.perseus.org/catalog/urn:cts:greekLit:tlg-0138');

-- --------------------------------------------------------

--
-- Structure de la table `authors_images_assoc`
--

CREATE TABLE `authors_images_assoc` (
  `author_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `author_translations`
--

CREATE TABLE `author_translations` (
  `id` int(11) NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `about` text COLLATE utf8_unicode_ci,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `books`
--

INSERT INTO `books` (`id`, `user_id`, `group_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, NULL, '2016-11-16 20:18:56', '2016-11-16 20:18:56');

-- --------------------------------------------------------

--
-- Structure de la table `books_translations`
--

CREATE TABLE `books_translations` (
  `id` int(11) NOT NULL,
  `book_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `books_translations`
--

INSERT INTO `books_translations` (`id`, `book_id`, `user_id`, `group_id`, `language_id`, `name`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, NULL, NULL, 'Mon livre', NULL, '2016-11-16 20:18:47', '2016-11-16 20:18:47'),
(2, NULL, NULL, NULL, NULL, 'Un autre livre', NULL, '2016-11-16 20:19:10', '2016-11-16 20:19:10'),
(3, 1, NULL, NULL, 4, 'Odyssée', NULL, '2016-11-16 20:21:29', '2016-11-29 19:43:59');

-- --------------------------------------------------------

--
-- Structure de la table `cities`
--

CREATE TABLE `cities` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `GPS` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `cities`
--

INSERT INTO `cities` (`id`, `user_id`, `group_id`, `GPS`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, '32° 39′ 21″ Nord, 35° 40′ 47″ Est', NULL, '2016-11-21 16:07:35', '2016-11-21 16:07:35');

-- --------------------------------------------------------

--
-- Structure de la table `cities_images_assoc`
--

CREATE TABLE `cities_images_assoc` (
  `city_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cities_translations`
--

CREATE TABLE `cities_translations` (
  `id` int(11) NOT NULL,
  `city_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `current_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `cities_translations`
--

INSERT INTO `cities_translations` (`id`, `city_id`, `user_id`, `group_id`, `language_id`, `name`, `current_name`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL, 2, 'Gadare', 'Umm Qeis', NULL, NULL, '2016-11-21 16:08:13', '2016-11-21 16:08:53'),
(2, NULL, NULL, NULL, 1, 'Gadara', 'Umm Qeis', NULL, NULL, '2016-11-21 16:09:35', '2016-11-21 16:09:35');

-- --------------------------------------------------------

--
-- Structure de la table `entities`
--

CREATE TABLE `entities` (
  `id` int(11) NOT NULL,
  `book_id` int(11) DEFAULT NULL,
  `era_id` int(11) DEFAULT NULL,
  `genre_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `title` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `date` smallint(6) DEFAULT NULL,
  `date_range` smallint(6) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `entities`
--

INSERT INTO `entities` (`id`, `book_id`, `era_id`, `genre_id`, `user_id`, `group_id`, `title`, `date`, `date_range`, `deleted_at`, `created_at`, `updated_at`) VALUES
(33, NULL, NULL, NULL, NULL, NULL, 'Greek Anthology 5.6', NULL, NULL, NULL, '2017-02-07 12:04:08', '2017-02-07 12:04:08'),
(38, NULL, NULL, NULL, NULL, NULL, 'Greek Anthology 4.1', NULL, NULL, NULL, '2017-02-13 17:58:47', '2017-02-13 17:58:47'),
(40, NULL, NULL, NULL, NULL, NULL, 'Greek Anthology 14.2', NULL, NULL, NULL, '2017-02-15 18:09:50', '2017-02-15 18:09:50'),
(41, NULL, NULL, NULL, NULL, NULL, 'Greek Anthology 14.7', NULL, NULL, NULL, '2017-02-15 19:51:16', '2017-02-15 19:51:16');

-- --------------------------------------------------------

--
-- Structure de la table `entities_authors_assoc`
--

CREATE TABLE `entities_authors_assoc` (
  `entities_id` int(11) NOT NULL,
  `authors_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `entities_authors_assoc`
--

INSERT INTO `entities_authors_assoc` (`entities_id`, `authors_id`) VALUES
(33, 9),
(38, 11),
(40, 12),
(41, 13);

-- --------------------------------------------------------

--
-- Structure de la table `entities_images_assoc`
--

CREATE TABLE `entities_images_assoc` (
  `entity_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `entities_keywords_assoc`
--

CREATE TABLE `entities_keywords_assoc` (
  `entities_id` int(11) NOT NULL,
  `keywords_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `entities_keywords_assoc`
--

INSERT INTO `entities_keywords_assoc` (`entities_id`, `keywords_id`) VALUES
(33, 1),
(33, 7);

-- --------------------------------------------------------

--
-- Structure de la table `entities_manuscripts_assoc`
--

CREATE TABLE `entities_manuscripts_assoc` (
  `entities_id` int(11) NOT NULL,
  `manuscripts_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `entities_motifs_assoc`
--

CREATE TABLE `entities_motifs_assoc` (
  `entities_id` int(11) NOT NULL,
  `motifs_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `entities_notes_assoc`
--

CREATE TABLE `entities_notes_assoc` (
  `entities_id` int(11) NOT NULL,
  `notes_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `entities_references`
--

CREATE TABLE `entities_references` (
  `source` int(11) NOT NULL,
  `destination` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `entities_references`
--

INSERT INTO `entities_references` (`source`, `destination`) VALUES
(33, 33);

-- --------------------------------------------------------

--
-- Structure de la table `entities_scholies_assoc`
--

CREATE TABLE `entities_scholies_assoc` (
  `entities_id` int(11) NOT NULL,
  `scholies_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `entities_texts_assoc`
--

CREATE TABLE `entities_texts_assoc` (
  `entities_id` int(11) NOT NULL,
  `texts_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `entities_translations`
--

CREATE TABLE `entities_translations` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `text_translated` text COLLATE utf8_unicode_ci,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `entities_translations`
--

INSERT INTO `entities_translations` (`id`, `entity_id`, `user_id`, `group_id`, `language_id`, `text_translated`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 33, 2, NULL, 12, '\n                     ὤμοσε Καλλίγνωτος Ἰωνίδι, μήποτε κείνης\nἕξειν μήτε φίλον κρέσσονα μήτε φίλην.\nὤμοσεν: ἀλλὰ λέγουσιν ἀληθέα, τοὺς ἐν ἔρωτι\n ὅρκους.μὴ δύνειν οὔατ᾽ ἐς ἀθανάτων.\n\n                      νῦν δ᾽ ὁ μὲν ἀρσενικῷ θέρεται πυρί: τῆς δὲ ταλαίνης\n νύμφης, ὡς Μεγαρέων, οὐ λόγος οὐδ᾽ ἀριθμός. .\n', NULL, '2017-02-07 12:04:08', '2017-02-07 12:04:08'),
(2, 33, 3, NULL, 1, 'Callignoto ha giurato a Ionide che mai\namerà qualcuno più di lei - né uomo né donna.\nL’ha giurato, ma è vero quel che dice la gente : i giuramenti in amore\nnon arrivano agli orecchi degli immortali.\nOra il fuoco che lo scalda è un ragazzo : la sua triste\ngiovane sposa, come i megarici, non la calcola più.', NULL, '2017-02-07 13:51:33', '2017-02-07 13:51:33'),
(4, 38, 13, NULL, 12, '\n                      Μοῦσα φίλα, τίνι τάνδε φέρεις πάγκαρπον ἀοιδάν;\nἢ τίς  ὁ καὶ τεύξας ὑμνοθετᾶν στέφανον;\n ἄνυσε μὲν Μελέαγρος, ἀριζάλῳ δὲ Διοκλεῖ\nμναμόσυνον ταύταν ἐξεπόνησε χάριν,\n\n                      πολλὰ μὲν ἐμπλέξας Ἀνύτης κρίνα, πολλὰ δὲ Μοιροῦς\nλείρια, καὶ Σαπφοῦς βαιὰ μέν, ἀλλὰ ῥόδα:\nνάρκισσόν τε τορῶν Μελανιππίδου ἔγκυον ὕμνων,\nκαὶ νέον οἰνάνθης κλῆμα Σιμωνίδεω:\n σὺν δ᾽ ἀναμὶξ πλέξας μυρόπνουν εὐάνθεμον ἶριν\n\n                      Νοσσίδος, ἧς δέλτοις κηρὸν ἔτηξεν Ἔρως:\nτῇ δ᾽ ἅμα καὶ σάμψυχον ἀφ᾽ ἡδυπνόοιο Ῥιανοῦ,\n καὶ γλυκὺν Ἠρίννης παρθενόχρωτα κρόκον,\n Ἀλκαίου τε λάληθρον ἐν ὑμνοπόλοις ὑάκινθον,\n καὶ Σαμίου δάφνης κλῶνα μελαμπέταλον\n\n                     ἐν δὲ Λεωνίδεω θαλεροὺς κισσοῖο κορύμβους,\n Μνασάλκου τε κόμας ὀξυτόρου πίτυος:\nβλαισήν τε πλατάνιστον ἀπέθρισε Παμφίλου οἴμης,\n σύμπλεκτον καρύης ἔρνεσι Παγκράτεος,\n\n                     Τύμνεὼ τ᾽ εὐπέταλον λεύκην, χλοερόν τε σίσυμβρον\n\n                      Νικίου, Εὐφήμου τ᾽ ἀμμότροφον πάραλον\nἐν δ᾽ ἄρα Δαμάγητον, ἴον μέλαν, ἡδύ τε μύρτον\n Καλλιμάχου, στυφελοῦ μεστὸν ἀεὶ μέλιτος,\n λυχνίδα τ᾽ Εὐφορίωνος, ἰδ᾽ ἐν Μούσαις κυκλάμινον,\nὃς Διὸς ἐκ κούρων ἔσχεν ἐπωνυμίην.\n\n                      τῇσι δ᾽ ἅμ᾽ Ἡγήσιππον ἐνέπλεκε, μαινάδα βότρυν,\n Πέρσου τ᾽ εὐώδη σχοῖνον ἀμησάμενος,\n σὺν δ᾽ ἅμα καὶ γλυκὺ μῆλον ἀπ᾽ ἀκρεμόνων Διοτίμου,\n καὶ ῥοιῆς ἄνθη πρῶτα Μενεκράτεος,\n σμυρναίους τε κλάδους Νικαινέτου, ἠδὲ Φαέννου\n\n                     τέρμινθον, βλωθρὴν τ᾽ ἀχράδα Σιμμίεω:\nἐν δὲ καὶ ἐκ λειμῶνος ἀμωμήτοιο σελίνου\n βαιὰ διακνίζων ἄνθεα Παρθενίδος,\nλείψανὰ τ᾽ εὐκαρπεῦντα μελιστάκτων ἀπὸ Μουσέων,\n ξανθοὺς ἐκ καλάμης Βακχυλίδεω στάχυας:\n\n                     ἐν δ᾽ ἄρ᾽ Ἀνακρείοντα, τὸ μὲν γλυκὺ κεῖνο μέλισμα,\nνέκταρος, εἰς δ᾽ ἐλέγους ἄσπορον ἀνθέμιον\nἐν δὲ καὶ ἐκ φορβῆς σκολιότριχος ἄνθος ἀκάνθης\n Ἀρχιλόχου, μικρὰς στράγγας ἀπ᾽ ὠκεανοῦ:\n τοῖς δ᾽ ἅμ᾽ Ἀλεξάνδροιο νέους ὄρπηκας ἐλαίης,\n\n                      ἠδὲ Πολυκλείτου πορφυρέην κύανον.\nἐν δ᾽ ἄρ᾽ ἀμάρακον ἧκε, Πολύστρατον, ἄνθος ἀοιδῶν,\nφοίνισσάν τε νέην κύπρον ἀπ᾽ Ἀντιπάτρου:\nκαὶ μὴν καὶ Συρίαν σταχυότριχα θήκατο νάρδον,\n ὑμνοθέταν, Ἑρμοῦ δῶρον ἀειδόμενον\n\n                     ἐν δὲ Ποσείδιππόν τε καὶ Ἡδύλον, ἄγρι᾽ ἀρούρης,\nΣικελίδεὼ τ᾽ ἀνέμοις ἄνθεα φυόμενα.\n\n                      ναὶ μὴν καὶ χρύσειον ἀεὶ θείοιο Πλάτωνος\n κλῶνα, τὸν ἐξ ἀρετῆς πάντοθι λαμπόμενον\n ἄστρων τ᾽ ἴδριν Ἄρατον ὁμοῦ βάλεν, οὐρανομάκεως\n\n                      φοίνικος κείρας πρωτογόνους ἕλικας,\nλωτὸν τ᾽ εὐχαίτην Χαιρήμονος, ἐν φλογὶ μίξας\n Φαιδίμου, Ἀνταγόρου τ᾽ εὔστροφον ὄμμα βοός,\nτάν τε φιλάκρητον Θεοδωρίδεω νεοθαλῆ\nἕρπυλλον, κυάμων τ᾽ ἄνθεα Φανίεω,\n\n                      ἄλλων τ᾽ ἔρνεα πολλὰ νεόγραφα: τοῖς δ᾽ ἅμα Μούσης\n καὶ σφετέρης ἔτι που πρώιμα λευκόια.\n ἀλλὰ φίλοις μὲν ἐμοῖσι φέρω χάριν ἔστι δὲ μύσταις\n κοινὸς ὁ τῶν Μουσέων ἡδυεπὴς στέφανος.\n', NULL, '2017-02-13 17:58:48', '2017-02-13 17:58:48'),
(5, 38, 13, NULL, 11, 'Cara Musa per chi porti questi frutti canori?', NULL, '2017-02-13 18:03:42', '2017-02-13 18:03:42'),
(6, 40, 40, NULL, 12, '\n                      Παλλὰς ἐγὼ χρυσῆ σφυρήλατος: αὐτὰρ ὁ χρυσὸς\n αἰζηῶν πέλεται δῶρον ἀοιδοπόλων.\nἥμισυ μὲν χρυσοῖο Χαρίσιος, ὀγδοάτην δὲ\n Θέσπις, καὶ δεκάτην μοῖραν ἔδωκε Σόλων,\n\n                     αὐτὰρ ἐεικοστὴν Θεμίσων τὰ δὲ λοιπὰ τάλαντα\n ἐννέα, καὶ τέχνη δῶρον Ἀριστοδίκου.\n\n                  ', NULL, '2017-02-15 18:09:51', '2017-02-15 18:09:51'),
(7, 41, 40, NULL, 12, '\n                     χάλκεός εἰμι λέων κρουνοὶ δέ μοι ὄμματα δοιά,\nκαὶ στόμα, καὶ δὲ θέναρ δεξιτεροῖο ποδός.\n πλήθει δὲ κρητῆρα δύ᾽ ἤμασι δεξιὸν ὄμμα,\nκαὶ λαιὸν τρισσοῖς, καὶ πισύροισι θέναρ:\n\n                      ἄρκιον ἓξ ὥραις πλῆσαι στόμα: σὺν δ᾽ ἅμα πάντα,\nκαὶ στόμα καὶ γλῆναι καὶ θέναρ, εἰπὲ πόσον.\n', NULL, '2017-02-15 19:51:16', '2017-02-15 19:51:16');

-- --------------------------------------------------------

--
-- Structure de la table `entities_translations_align`
--

CREATE TABLE `entities_translations_align` (
  `align_id` int(11) NOT NULL,
  `pair` varchar(23) NOT NULL,
  `json` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `created_at` date NOT NULL,
  `modified_at` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `entities_translations_align`
--

INSERT INTO `entities_translations_align` (`align_id`, `pair`, `json`, `user_id`, `group_id`, `created_at`, `modified_at`) VALUES
(1, '1;2', '[[[],[{\"t\":\"ὤμοσε\",\"h\":[[1],[2,3]]},{\"t\":\"Καλλίγνωτος\",\"h\":[[2],[]]},{\"t\":\"Ἰωνίδι\",\"h\":[[3],[]]},{\"p\":\",\"},{\"t\":\"μήποτε\",\"h\":[[5],[]]},{\"t\":\"κείνης\",\"h\":[[6],[]]}],[{\"t\":\"ἕξειν\",\"h\":[[7],[]]},{\"t\":\"μήτε\",\"h\":[[8],[]]},{\"t\":\"φίλον\",\"h\":[[9],[]]},{\"t\":\"κρέσσονα\",\"h\":[[10],[]]},{\"t\":\"μήτε\",\"h\":[[11],[]]},{\"t\":\"φίλην\",\"h\":[[12],[]]},{\"p\":\".\"}],[{\"t\":\"ὤμοσεν\",\"h\":[[14],[]]},{\"p\":\":\"},{\"t\":\"ἀλλὰ\",\"h\":[[16],[]]},{\"t\":\"λέγουσιν\",\"h\":[[17],[]]},{\"t\":\"ἀληθέα\",\"h\":[[18],[]]},{\"p\":\",\"},{\"t\":\"τοὺς\",\"h\":[[20],[]]},{\"t\":\"ἐν\",\"h\":[[21],[]]},{\"t\":\"ἔρωτι\",\"h\":[[22],[]]}],[{\"t\":\"ὅρκους\",\"h\":[[23],[]]},{\"p\":\".\"},{\"t\":\"μὴ\",\"h\":[[25],[]]},{\"t\":\"δύνειν\",\"h\":[[26],[]]},{\"t\":\"οὔατ᾽\",\"h\":[[27],[]]},{\"t\":\"ἐς\",\"h\":[[28],[]]},{\"t\":\"ἀθανάτων\",\"h\":[[29],[]]},{\"p\":\".\"}],[],[{\"t\":\"νῦν\",\"h\":[[31],[]]},{\"t\":\"δ᾽\",\"h\":[[32],[]]},{\"t\":\"ὁ\",\"h\":[[33],[]]},{\"t\":\"μὲν\",\"h\":[[34],[]]},{\"t\":\"ἀρσενικῷ\",\"h\":[[35],[]]},{\"t\":\"θέρεται\",\"h\":[[36],[]]},{\"t\":\"πυρί\",\"h\":[[37],[]]},{\"p\":\":\"},{\"t\":\"τῆς\",\"h\":[[39],[]]},{\"t\":\"δὲ\",\"h\":[[40],[]]},{\"t\":\"ταλαίνης\",\"h\":[[41],[]]}],[{\"t\":\"νύμφης\",\"h\":[[42],[]]},{\"p\":\",\"},{\"t\":\"ὡς\",\"h\":[[44],[]]},{\"t\":\"Μεγαρέων\",\"h\":[[45],[]]},{\"p\":\",\"},{\"t\":\"οὐ\",\"h\":[[47],[]]},{\"t\":\"λόγος\",\"h\":[[48],[]]},{\"t\":\"οὐδ᾽\",\"h\":[[49],[]]},{\"t\":\"ἀριθμός\",\"h\":[[50],[]]},{\"p\":\".\"},{\"p\":\".\"}],[]],[[{\"t\":\"Callignoto\",\"h\":[[],[1]]},{\"t\":\"ha\",\"h\":[[1],[2,3]]},{\"t\":\"giurato\",\"h\":[[1],[2,3]]},{\"t\":\"a\",\"h\":[[],[4]]},{\"t\":\"Ionide\",\"h\":[[],[5]]},{\"t\":\"che\",\"h\":[[],[6]]},{\"t\":\"mai\",\"h\":[[],[7]]}],[{\"t\":\"amerà\",\"h\":[[],[8]]},{\"t\":\"qualcuno\",\"h\":[[],[9]]},{\"t\":\"più\",\"h\":[[],[10]]},{\"t\":\"di\",\"h\":[[],[11]]},{\"t\":\"lei\",\"h\":[[],[12]]},{\"p\":\"-\"},{\"t\":\"né\",\"h\":[[],[14]]},{\"t\":\"uomo\",\"h\":[[],[15]]},{\"t\":\"né\",\"h\":[[],[16]]},{\"t\":\"donna\",\"h\":[[],[17]]},{\"p\":\".\"}],[{\"t\":\"L\",\"h\":[[],[19]]},{\"p\":\"’\"},{\"t\":\"ha\",\"h\":[[],[21]]},{\"t\":\"giurato\",\"h\":[[],[22]]},{\"p\":\",\"},{\"t\":\"ma\",\"h\":[[],[24]]},{\"p\":\"è\"},{\"t\":\"vero\",\"h\":[[],[26]]},{\"t\":\"quel\",\"h\":[[],[27]]},{\"t\":\"che\",\"h\":[[],[28]]},{\"t\":\"dice\",\"h\":[[],[29]]},{\"t\":\"la\",\"h\":[[],[30]]},{\"t\":\"gente\",\"h\":[[],[31]]},{\"p\":\":\"},{\"t\":\"i\",\"h\":[[],[33]]},{\"t\":\"giuramenti\",\"h\":[[],[34]]},{\"t\":\"in\",\"h\":[[],[35]]},{\"t\":\"amore\",\"h\":[[],[36]]}],[{\"t\":\"non\",\"h\":[[],[37]]},{\"t\":\"arrivano\",\"h\":[[],[38]]},{\"t\":\"agli\",\"h\":[[],[39]]},{\"t\":\"orecchi\",\"h\":[[],[40]]},{\"t\":\"degli\",\"h\":[[],[41]]},{\"t\":\"immortali\",\"h\":[[],[42]]},{\"p\":\".\"}],[{\"t\":\"Ora\",\"h\":[[],[44]]},{\"t\":\"il\",\"h\":[[],[45]]},{\"t\":\"fuoco\",\"h\":[[],[46]]},{\"t\":\"che\",\"h\":[[],[47]]},{\"t\":\"lo\",\"h\":[[],[48]]},{\"t\":\"scalda\",\"h\":[[],[49]]},{\"p\":\"è\"},{\"t\":\"un\",\"h\":[[],[51]]},{\"t\":\"ragazzo\",\"h\":[[],[52]]},{\"p\":\":\"},{\"t\":\"la\",\"h\":[[],[54]]},{\"t\":\"sua\",\"h\":[[],[55]]},{\"t\":\"triste\",\"h\":[[],[56]]}],[{\"t\":\"giovane\",\"h\":[[],[57]]},{\"t\":\"sposa\",\"h\":[[],[58]]},{\"p\":\",\"},{\"t\":\"come\",\"h\":[[],[60]]},{\"t\":\"i\",\"h\":[[],[61]]},{\"t\":\"megarici\",\"h\":[[],[62]]},{\"p\":\",\"},{\"t\":\"non\",\"h\":[[],[64]]},{\"t\":\"la\",\"h\":[[],[65]]},{\"t\":\"calcola\",\"h\":[[],[66]]},{\"t\":\"più\",\"h\":[[],[67]]},{\"p\":\".\"}]]]', 12, NULL, '2017-02-07', '2017-02-07'),
(6, '1;2', '[[[],[{\"t\":\"ὤμοσε\",\"h\":[[1,2],[1,2,3]]},{\"t\":\"Καλλίγνωτος\",\"h\":[[1,2],[1,2,3]]},{\"t\":\"Ἰωνίδι\",\"h\":[[3],[]]},{\"p\":\",\"},{\"t\":\"μήποτε\",\"h\":[[5],[]]},{\"t\":\"κείνης\",\"h\":[[6],[]]}],[{\"t\":\"ἕξειν\",\"h\":[[7],[]]},{\"t\":\"μήτε\",\"h\":[[8],[]]},{\"t\":\"φίλον\",\"h\":[[9],[]]},{\"t\":\"κρέσσονα\",\"h\":[[10],[]]},{\"t\":\"μήτε\",\"h\":[[11],[]]},{\"t\":\"φίλην\",\"h\":[[12],[]]},{\"p\":\".\"}],[{\"t\":\"ὤμοσεν\",\"h\":[[14],[]]},{\"p\":\":\"},{\"t\":\"ἀλλὰ\",\"h\":[[16],[]]},{\"t\":\"λέγουσιν\",\"h\":[[17],[]]},{\"t\":\"ἀληθέα\",\"h\":[[18],[]]},{\"p\":\",\"},{\"t\":\"τοὺς\",\"h\":[[20],[]]},{\"t\":\"ἐν\",\"h\":[[21],[]]},{\"t\":\"ἔρωτι\",\"h\":[[22],[]]}],[{\"t\":\"ὅρκους\",\"h\":[[23],[]]},{\"p\":\".\"},{\"t\":\"μὴ\",\"h\":[[25],[]]},{\"t\":\"δύνειν\",\"h\":[[26],[]]},{\"t\":\"οὔατ᾽\",\"h\":[[27],[]]},{\"t\":\"ἐς\",\"h\":[[28],[]]},{\"t\":\"ἀθανάτων\",\"h\":[[29],[]]},{\"p\":\".\"}],[],[{\"t\":\"νῦν\",\"h\":[[31],[]]},{\"t\":\"δ᾽\",\"h\":[[32],[]]},{\"t\":\"ὁ\",\"h\":[[33],[]]},{\"t\":\"μὲν\",\"h\":[[34],[]]},{\"t\":\"ἀρσενικῷ\",\"h\":[[35],[]]},{\"t\":\"θέρεται\",\"h\":[[36],[]]},{\"t\":\"πυρί\",\"h\":[[37],[]]},{\"p\":\":\"},{\"t\":\"τῆς\",\"h\":[[39],[]]},{\"t\":\"δὲ\",\"h\":[[40],[]]},{\"t\":\"ταλαίνης\",\"h\":[[41],[]]}],[{\"t\":\"νύμφης\",\"h\":[[42],[]]},{\"p\":\",\"},{\"t\":\"ὡς\",\"h\":[[44],[]]},{\"t\":\"Μεγαρέων\",\"h\":[[45],[]]},{\"p\":\",\"},{\"t\":\"οὐ\",\"h\":[[47],[]]},{\"t\":\"λόγος\",\"h\":[[48],[]]},{\"t\":\"οὐδ᾽\",\"h\":[[49],[]]},{\"t\":\"ἀριθμός\",\"h\":[[50],[]]},{\"p\":\".\"},{\"p\":\".\"}],[]],[[{\"t\":\"Callignoto\",\"h\":[[1,2],[1,2,3]]},{\"t\":\"ha\",\"h\":[[1,2],[1,2,3]]},{\"t\":\"giurato\",\"h\":[[1,2],[1,2,3]]},{\"t\":\"a\",\"h\":[[],[4]]},{\"t\":\"Ionide\",\"h\":[[],[5]]},{\"t\":\"che\",\"h\":[[],[6]]},{\"t\":\"mai\",\"h\":[[],[7]]}],[{\"t\":\"amerà\",\"h\":[[],[8]]},{\"t\":\"qualcuno\",\"h\":[[],[9]]},{\"t\":\"più\",\"h\":[[],[10]]},{\"t\":\"di\",\"h\":[[],[11]]},{\"t\":\"lei\",\"h\":[[],[12]]},{\"p\":\"-\"},{\"t\":\"né\",\"h\":[[],[14]]},{\"t\":\"uomo\",\"h\":[[],[15]]},{\"t\":\"né\",\"h\":[[],[16]]},{\"t\":\"donna\",\"h\":[[],[17]]},{\"p\":\".\"}],[{\"t\":\"L\",\"h\":[[],[19]]},{\"p\":\"’\"},{\"t\":\"ha\",\"h\":[[],[21]]},{\"t\":\"giurato\",\"h\":[[],[22]]},{\"p\":\",\"},{\"t\":\"ma\",\"h\":[[],[24]]},{\"p\":\"è\"},{\"t\":\"vero\",\"h\":[[],[26]]},{\"t\":\"quel\",\"h\":[[],[27]]},{\"t\":\"che\",\"h\":[[],[28]]},{\"t\":\"dice\",\"h\":[[],[29]]},{\"t\":\"la\",\"h\":[[],[30]]},{\"t\":\"gente\",\"h\":[[],[31]]},{\"p\":\":\"},{\"t\":\"i\",\"h\":[[],[33]]},{\"t\":\"giuramenti\",\"h\":[[],[34]]},{\"t\":\"in\",\"h\":[[],[35]]},{\"t\":\"amore\",\"h\":[[],[36]]}],[{\"t\":\"non\",\"h\":[[],[37]]},{\"t\":\"arrivano\",\"h\":[[],[38]]},{\"t\":\"agli\",\"h\":[[],[39]]},{\"t\":\"orecchi\",\"h\":[[],[40]]},{\"t\":\"degli\",\"h\":[[],[41]]},{\"t\":\"immortali\",\"h\":[[],[42]]},{\"p\":\".\"}],[{\"t\":\"Ora\",\"h\":[[],[44]]},{\"t\":\"il\",\"h\":[[],[45]]},{\"t\":\"fuoco\",\"h\":[[],[46]]},{\"t\":\"che\",\"h\":[[],[47]]},{\"t\":\"lo\",\"h\":[[],[48]]},{\"t\":\"scalda\",\"h\":[[],[49]]},{\"p\":\"è\"},{\"t\":\"un\",\"h\":[[],[51]]},{\"t\":\"ragazzo\",\"h\":[[],[52]]},{\"p\":\":\"},{\"t\":\"la\",\"h\":[[],[54]]},{\"t\":\"sua\",\"h\":[[],[55]]},{\"t\":\"triste\",\"h\":[[],[56]]}],[{\"t\":\"giovane\",\"h\":[[],[57]]},{\"t\":\"sposa\",\"h\":[[],[58]]},{\"p\":\",\"},{\"t\":\"come\",\"h\":[[],[60]]},{\"t\":\"i\",\"h\":[[],[61]]},{\"t\":\"megarici\",\"h\":[[],[62]]},{\"p\":\",\"},{\"t\":\"non\",\"h\":[[],[64]]},{\"t\":\"la\",\"h\":[[],[65]]},{\"t\":\"calcola\",\"h\":[[],[66]]},{\"t\":\"più\",\"h\":[[],[67]]},{\"p\":\".\"}]]]', 2, NULL, '2017-02-13', '2017-02-13'),
(7, '1;2', '[[[],[{\"t\":\"ὤμοσε\",\"h\":[[1],[2,3]]},{\"t\":\"Καλλίγνωτος\",\"h\":[[2],[]]},{\"t\":\"Ἰωνίδι\",\"h\":[[3],[]]},{\"p\":\",\"},{\"t\":\"μήποτε\",\"h\":[[5],[]]},{\"t\":\"κείνης\",\"h\":[[6],[]]}],[{\"t\":\"ἕξειν\",\"h\":[[7],[]]},{\"t\":\"μήτε\",\"h\":[[8],[]]},{\"t\":\"φίλον\",\"h\":[[9],[]]},{\"t\":\"κρέσσονα\",\"h\":[[10],[]]},{\"t\":\"μήτε\",\"h\":[[11],[]]},{\"t\":\"φίλην\",\"h\":[[12],[]]},{\"p\":\".\"}],[{\"t\":\"ὤμοσεν\",\"h\":[[14],[]]},{\"p\":\":\"},{\"t\":\"ἀλλὰ\",\"h\":[[16],[]]},{\"t\":\"λέγουσιν\",\"h\":[[17],[]]},{\"t\":\"ἀληθέα\",\"h\":[[18],[]]},{\"p\":\",\"},{\"t\":\"τοὺς\",\"h\":[[20,21,22],[35,36]]},{\"t\":\"ἐν\",\"h\":[[20,21,22],[35,36]]},{\"t\":\"ἔρωτι\",\"h\":[[20,21,22],[35,36]]}],[{\"t\":\"ὅρκους\",\"h\":[[23],[34]]},{\"p\":\".\"},{\"t\":\"μὴ\",\"h\":[[25],[]]},{\"t\":\"δύνειν\",\"h\":[[26],[]]},{\"t\":\"οὔατ᾽\",\"h\":[[27],[]]},{\"t\":\"ἐς\",\"h\":[[28],[]]},{\"t\":\"ἀθανάτων\",\"h\":[[29],[]]},{\"p\":\".\"}],[],[{\"t\":\"νῦν\",\"h\":[[31],[]]},{\"t\":\"δ᾽\",\"h\":[[32],[]]},{\"t\":\"ὁ\",\"h\":[[33],[]]},{\"t\":\"μὲν\",\"h\":[[34],[]]},{\"t\":\"ἀρσενικῷ\",\"h\":[[35],[]]},{\"t\":\"θέρεται\",\"h\":[[36],[]]},{\"t\":\"πυρί\",\"h\":[[37],[]]},{\"p\":\":\"},{\"t\":\"τῆς\",\"h\":[[39],[]]},{\"t\":\"δὲ\",\"h\":[[40],[]]},{\"t\":\"ταλαίνης\",\"h\":[[41],[]]}],[{\"t\":\"νύμφης\",\"h\":[[42],[]]},{\"p\":\",\"},{\"t\":\"ὡς\",\"h\":[[44],[]]},{\"t\":\"Μεγαρέων\",\"h\":[[45],[]]},{\"p\":\",\"},{\"t\":\"οὐ\",\"h\":[[47],[]]},{\"t\":\"λόγος\",\"h\":[[48],[]]},{\"t\":\"οὐδ᾽\",\"h\":[[49],[]]},{\"t\":\"ἀριθμός\",\"h\":[[50],[]]},{\"p\":\".\"},{\"p\":\".\"}],[]],[[{\"t\":\"Callignoto\",\"h\":[[],[1]]},{\"t\":\"ha\",\"h\":[[1],[2,3]]},{\"t\":\"giurato\",\"h\":[[1],[2,3]]},{\"t\":\"a\",\"h\":[[],[4]]},{\"t\":\"Ionide\",\"h\":[[],[5]]},{\"t\":\"che\",\"h\":[[],[6]]},{\"t\":\"mai\",\"h\":[[],[7]]}],[{\"t\":\"amerà\",\"h\":[[],[8]]},{\"t\":\"qualcuno\",\"h\":[[],[9]]},{\"t\":\"più\",\"h\":[[],[10]]},{\"t\":\"di\",\"h\":[[],[11]]},{\"t\":\"lei\",\"h\":[[],[12]]},{\"p\":\"-\"},{\"t\":\"né\",\"h\":[[],[14]]},{\"t\":\"uomo\",\"h\":[[],[15]]},{\"t\":\"né\",\"h\":[[],[16]]},{\"t\":\"donna\",\"h\":[[],[17]]},{\"p\":\".\"}],[{\"t\":\"L\",\"h\":[[],[19]]},{\"p\":\"’\"},{\"t\":\"ha\",\"h\":[[],[21]]},{\"t\":\"giurato\",\"h\":[[],[22]]},{\"p\":\",\"},{\"t\":\"ma\",\"h\":[[],[24]]},{\"p\":\"è\"},{\"t\":\"vero\",\"h\":[[],[26]]},{\"t\":\"quel\",\"h\":[[],[27]]},{\"t\":\"che\",\"h\":[[],[28]]},{\"t\":\"dice\",\"h\":[[],[29]]},{\"t\":\"la\",\"h\":[[],[30]]},{\"t\":\"gente\",\"h\":[[],[31]]},{\"p\":\":\"},{\"t\":\"i\",\"h\":[[],[33]]},{\"t\":\"giuramenti\",\"h\":[[23],[34]]},{\"t\":\"in\",\"h\":[[20,21,22],[35,36]]},{\"t\":\"amore\",\"h\":[[20,21,22],[35,36]]}],[{\"t\":\"non\",\"h\":[[],[37]]},{\"t\":\"arrivano\",\"h\":[[],[38]]},{\"t\":\"agli\",\"h\":[[],[39]]},{\"t\":\"orecchi\",\"h\":[[],[40]]},{\"t\":\"degli\",\"h\":[[],[41]]},{\"t\":\"immortali\",\"h\":[[],[42]]},{\"p\":\".\"}],[{\"t\":\"Ora\",\"h\":[[],[44]]},{\"t\":\"il\",\"h\":[[],[45]]},{\"t\":\"fuoco\",\"h\":[[],[46]]},{\"t\":\"che\",\"h\":[[],[47]]},{\"t\":\"lo\",\"h\":[[],[48]]},{\"t\":\"scalda\",\"h\":[[],[49]]},{\"p\":\"è\"},{\"t\":\"un\",\"h\":[[],[51]]},{\"t\":\"ragazzo\",\"h\":[[],[52]]},{\"p\":\":\"},{\"t\":\"la\",\"h\":[[],[54]]},{\"t\":\"sua\",\"h\":[[],[55]]},{\"t\":\"triste\",\"h\":[[],[56]]}],[{\"t\":\"giovane\",\"h\":[[],[57]]},{\"t\":\"sposa\",\"h\":[[],[58]]},{\"p\":\",\"},{\"t\":\"come\",\"h\":[[],[60]]},{\"t\":\"i\",\"h\":[[],[61]]},{\"t\":\"megarici\",\"h\":[[],[62]]},{\"p\":\",\"},{\"t\":\"non\",\"h\":[[],[64]]},{\"t\":\"la\",\"h\":[[],[65]]},{\"t\":\"calcola\",\"h\":[[],[66]]},{\"t\":\"più\",\"h\":[[],[67]]},{\"p\":\".\"}]]]', 13, NULL, '2017-02-13', '2017-02-13');

-- --------------------------------------------------------

--
-- Structure de la table `eras`
--

CREATE TABLE `eras` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `date_begin` smallint(6) DEFAULT NULL,
  `date_end` smallint(6) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `eras`
--

INSERT INTO `eras` (`id`, `user_id`, `group_id`, `date_begin`, `date_end`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, -11, 42, NULL, '2016-11-16 20:19:58', '2016-11-16 20:19:58');

-- --------------------------------------------------------

--
-- Structure de la table `eras_images_assoc`
--

CREATE TABLE `eras_images_assoc` (
  `author_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `eras_translations`
--

CREATE TABLE `eras_translations` (
  `id` int(11) NOT NULL,
  `era_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `culture_centers` text COLLATE utf8_unicode_ci,
  `description` text COLLATE utf8_unicode_ci,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fos_groups`
--

CREATE TABLE `fos_groups` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fos_users`
--

CREATE TABLE `fos_users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `username_canonical` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email_canonical` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `expired` tinyint(1) NOT NULL DEFAULT '0',
  `expires_at` datetime DEFAULT NULL,
  `confirmation_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_requested_at` datetime DEFAULT NULL,
  `roles` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `credentials_expired` tinyint(1) NOT NULL DEFAULT '0',
  `credentials_expire_at` datetime DEFAULT NULL,
  `first_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `institution` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `fos_users`
--


-- --------------------------------------------------------

--
-- Structure de la table `fos_users_groups`
--

CREATE TABLE `fos_users_groups` (
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `genres`
--

CREATE TABLE `genres` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `genres`
--

INSERT INTO `genres` (`id`, `user_id`, `group_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, NULL, '2016-11-16 20:20:10', '2016-11-16 20:20:10');

-- --------------------------------------------------------

--
-- Structure de la table `genres_translations`
--

CREATE TABLE `genres_translations` (
  `id` int(11) NOT NULL,
  `genre_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `title` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `genres_translations`
--

INSERT INTO `genres_translations` (`id`, `genre_id`, `user_id`, `group_id`, `language_id`, `title`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL, NULL, 'Gonzo', NULL, NULL, '2016-11-16 20:20:40', '2016-11-16 20:21:16');

-- --------------------------------------------------------

--
-- Structure de la table `images`
--

CREATE TABLE `images` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `date` smallint(6) DEFAULT NULL,
  `date_range` smallint(6) DEFAULT NULL,
  `URL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `file` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `credit` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `keywords`
--

CREATE TABLE `keywords` (
  `id` int(11) NOT NULL,
  `keyword_family` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `keywords`
--

INSERT INTO `keywords` (`id`, `keyword_family`, `user_id`, `group_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL, NULL, '2016-12-09 16:45:41', '2016-12-09 16:45:41'),
(7, 5, 3, NULL, NULL, '2017-02-27 19:15:26', '2017-02-27 19:15:26');

-- --------------------------------------------------------

--
-- Structure de la table `keywords_categories`
--

CREATE TABLE `keywords_categories` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `keywords_categories`
--

INSERT INTO `keywords_categories` (`id`, `user_id`, `group_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, NULL, '2016-12-09 16:45:56', '2016-12-09 16:45:56');

-- --------------------------------------------------------

--
-- Structure de la table `keywords_categories_assoc`
--

CREATE TABLE `keywords_categories_assoc` (
  `keywords_id` int(11) NOT NULL,
  `keywords_categories_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `keywords_categories_translation`
--

CREATE TABLE `keywords_categories_translation` (
  `id` int(11) NOT NULL,
  `keyword_category_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `label` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `keywords_categories_translation`
--

INSERT INTO `keywords_categories_translation` (`id`, `keyword_category_id`, `user_id`, `group_id`, `language_id`, `label`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL, 2, 'Dieux', 'Dieux cités', NULL, '2016-12-09 16:46:31', '2016-12-09 16:46:31');

-- --------------------------------------------------------

--
-- Structure de la table `keywords_families`
--

CREATE TABLE `keywords_families` (
  `id` int(11) NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `keywords_families`
--

INSERT INTO `keywords_families` (`id`, `name`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'people', NULL, '2016-12-09 16:45:09', '2016-12-09 16:45:09'),
(2, 'character', NULL, '2017-01-31 23:01:24', '2017-01-31 23:01:24'),
(3, 'era', '2017-01-31 23:02:12', '2017-01-31 23:02:12', NULL),
(5, 'Metre', '2017-01-31 23:04:22', '2017-01-31 23:04:22', NULL),
(6, 'Topoi', NULL, '2017-02-27 19:19:25', '2017-02-27 19:19:25');

-- --------------------------------------------------------

--
-- Structure de la table `keywords_images_assoc`
--

CREATE TABLE `keywords_images_assoc` (
  `keyword_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `keywords_translations`
--

CREATE TABLE `keywords_translations` (
  `id` int(11) NOT NULL,
  `keyword_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `title` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `keywords_translations`
--

INSERT INTO `keywords_translations` (`id`, `keyword_id`, `user_id`, `group_id`, `language_id`, `title`, `description`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 2, NULL, 1, 'test', 'test keyword', NULL, '2017-02-18 17:51:18', '2017-02-18 17:51:18'),
(2, 1, 2, NULL, 2, 'test2', 'test keyword2', NULL, '2017-02-18 17:51:18', '2017-02-18 17:51:18'),
(7, 7, 3, NULL, 2, 'distique élégiaque', 'distique élégiaque', NULL, '2017-02-27 19:15:26', '2017-02-27 19:15:26');

-- --------------------------------------------------------

--
-- Structure de la table `languages`
--

CREATE TABLE `languages` (
  `id` int(11) NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `family` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `languages`
--

INSERT INTO `languages` (`id`, `name`, `family`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'italiano moderno', 'italiano', NULL, '2017-01-08 22:48:37', '2017-01-09 03:07:24'),
(2, 'français moderne', 'français', NULL, '2017-01-08 22:48:37', '2017-01-09 03:07:28'),
(3, 'modern english', 'english', NULL, '2017-01-08 22:48:37', '2017-01-09 03:07:49'),
(4, 'αρχαία ελληνικά', 'ελληνικά', NULL, '2017-01-08 22:48:37', '2017-01-09 03:08:21'),
(5, 'français littéraire', 'français', NULL, '2017-01-09 07:30:12', '2017-01-09 07:30:12'),
(7, 'français littéral', 'français', NULL, '2017-01-09 07:34:24', '2017-01-09 07:34:24'),
(11, 'greco versione Cagnazzi', 'ελληνικά', NULL, '2017-01-23 21:46:54', '2017-01-23 21:46:54'),
(12, 'perseus', 'ελληνικά', NULL, '2017-01-23 21:48:25', '2017-01-23 21:48:25');

-- --------------------------------------------------------

--
-- Structure de la table `manuscripts`
--

CREATE TABLE `manuscripts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `manuscripts_images_assoc`
--

CREATE TABLE `manuscripts_images_assoc` (
  `manuscript_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `manuscripts_scholies_assoc`
--

CREATE TABLE `manuscripts_scholies_assoc` (
  `manuscripts_id` int(11) NOT NULL,
  `scholies_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `manuscripts_translations`
--

CREATE TABLE `manuscripts_translations` (
  `id` int(11) NOT NULL,
  `manuscript_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `page` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `motifs`
--

CREATE TABLE `motifs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `motifs_translations`
--

CREATE TABLE `motifs_translations` (
  `id` int(11) NOT NULL,
  `motif_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `title` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `notes`
--

CREATE TABLE `notes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `notes_translations`
--

CREATE TABLE `notes_translations` (
  `id` int(11) NOT NULL,
  `note_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `text` text COLLATE utf8_unicode_ci,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oauth2_access_tokens`
--

CREATE TABLE `oauth2_access_tokens` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expires_at` int(11) DEFAULT NULL,
  `scope` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oauth2_auth_codes`
--

CREATE TABLE `oauth2_auth_codes` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `redirect_uri` longtext COLLATE utf8_unicode_ci NOT NULL,
  `expires_at` int(11) DEFAULT NULL,
  `scope` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oauth2_clients`
--

CREATE TABLE `oauth2_clients` (
  `id` int(11) NOT NULL,
  `random_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `redirect_uris` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `allowed_grant_types` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `oauth2_refresh_tokens`
--

CREATE TABLE `oauth2_refresh_tokens` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expires_at` int(11) DEFAULT NULL,
  `scope` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `scholies`
--

CREATE TABLE `scholies` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `scholies_images_assoc`
--

CREATE TABLE `scholies_images_assoc` (
  `scholie_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `scholies_translations`
--

CREATE TABLE `scholies_translations` (
  `id` int(11) NOT NULL,
  `scholie_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `text_translated` text COLLATE utf8_unicode_ci,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `texts`
--

CREATE TABLE `texts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `texts_translations`
--

CREATE TABLE `texts_translations` (
  `id` int(11) NOT NULL,
  `text_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `editor` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sound_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `URId`
--

CREATE TABLE `URId` (
  `id` int(11) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `urid_category_id` int(11) DEFAULT NULL,
  `urid_source_id` int(11) DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `URN` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `URId`
--

INSERT INTO `URId` (`id`, `entity_id`, `user_id`, `group_id`, `urid_category_id`, `urid_source_id`, `value`, `URN`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 33, 2, NULL, NULL, 1, 'http://data.perseus.org/citations/urn:cts:greekLit:tlg7000.tlg001.perseus-grc1:5.6', 'urn:cts:greekLit:tlg7000.tlg001.perseus-grc1:5.6', NULL, '2017-02-07 12:04:08', '2017-02-07 12:04:08'),
(2, NULL, 3, NULL, NULL, 1, 'http://data.perseus.org/citations/urn:cts:greekLit:tlg7000.tlg001.perseus-grc1:4.1.', 'urn:cts:greekLit:tlg7000.tlg001.perseus-grc1:4.1.', NULL, '2017-02-13 17:49:51', '2017-02-13 17:49:51'),
(3, 38, 13, NULL, NULL, 1, 'http://data.perseus.org/citations/urn:cts:greekLit:tlg7000.tlg001.perseus-grc1:4.1', 'urn:cts:greekLit:tlg7000.tlg001.perseus-grc1:4.1', NULL, '2017-02-13 17:58:47', '2017-02-13 17:58:47'),
(4, 40, 40, NULL, NULL, 1, 'http://data.perseus.org/citations/urn:cts:greekLit:tlg7000.tlg001.perseus-grc5:14.2', 'urn:cts:greekLit:tlg7000.tlg001.perseus-grc5:14.2', NULL, '2017-02-15 18:09:51', '2017-02-15 18:09:51'),
(5, 41, 40, NULL, NULL, 1, 'http://data.perseus.org/citations/urn:cts:greekLit:tlg7000.tlg001.perseus-grc5:14.7', 'urn:cts:greekLit:tlg7000.tlg001.perseus-grc5:14.7', NULL, '2017-02-15 19:51:16', '2017-02-15 19:51:16');

-- --------------------------------------------------------

--
-- Structure de la table `URId_categories`
--

CREATE TABLE `URId_categories` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `URId_categories_translation`
--

CREATE TABLE `URId_categories_translation` (
  `id` int(11) NOT NULL,
  `urid_category_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `label` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `URI_source`
--

CREATE TABLE `URI_source` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `base` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `URI_source`
--

INSERT INTO `URI_source` (`id`, `user_id`, `group_id`, `name`, `base`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 2, NULL, 'Perseus citation URI', 'http://data.perseus.org/citations/', NULL, '2017-01-09 10:38:43', '2017-01-09 10:38:43');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_8E0C2A51444AED2` (`city_born_id`),
  ADD KEY `IDX_8E0C2A51CB0D303` (`city_died_id`),
  ADD KEY `IDX_8E0C2A51707300A1` (`era_id`),
  ADD KEY `IDX_8E0C2A51A76ED395` (`user_id`),
  ADD KEY `IDX_8E0C2A51FE54D947` (`group_id`);

--
-- Index pour la table `authors_authority`
--
ALTER TABLE `authors_authority`
  ADD UNIQUE KEY `uniqueness` (`id_author_authority`);

--
-- Index pour la table `authors_images_assoc`
--
ALTER TABLE `authors_images_assoc`
  ADD PRIMARY KEY (`author_id`,`image_id`),
  ADD KEY `IDX_D83CC21CF675F31B` (`author_id`),
  ADD KEY `IDX_D83CC21C3DA5256D` (`image_id`);

--
-- Index pour la table `author_translations`
--
ALTER TABLE `author_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_9835D2EAF675F31B` (`author_id`),
  ADD KEY `IDX_9835D2EAA76ED395` (`user_id`),
  ADD KEY `IDX_9835D2EAFE54D947` (`group_id`),
  ADD KEY `IDX_9835D2EA82F1BAF4` (`language_id`);

--
-- Index pour la table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_4A1B2A92A76ED395` (`user_id`),
  ADD KEY `IDX_4A1B2A92FE54D947` (`group_id`);

--
-- Index pour la table `books_translations`
--
ALTER TABLE `books_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_1E9469D716A2B381` (`book_id`),
  ADD KEY `IDX_1E9469D7A76ED395` (`user_id`),
  ADD KEY `IDX_1E9469D7FE54D947` (`group_id`),
  ADD KEY `IDX_1E9469D782F1BAF4` (`language_id`);

--
-- Index pour la table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D95DB16BA76ED395` (`user_id`),
  ADD KEY `IDX_D95DB16BFE54D947` (`group_id`);

--
-- Index pour la table `cities_images_assoc`
--
ALTER TABLE `cities_images_assoc`
  ADD PRIMARY KEY (`city_id`,`image_id`),
  ADD KEY `IDX_1AAFF0D28BAC62AF` (`city_id`),
  ADD KEY `IDX_1AAFF0D23DA5256D` (`image_id`);

--
-- Index pour la table `cities_translations`
--
ALTER TABLE `cities_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_8AB3FCF88BAC62AF` (`city_id`),
  ADD KEY `IDX_8AB3FCF8A76ED395` (`user_id`),
  ADD KEY `IDX_8AB3FCF8FE54D947` (`group_id`),
  ADD KEY `IDX_8AB3FCF882F1BAF4` (`language_id`);

--
-- Index pour la table `entities`
--
ALTER TABLE `entities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_50EC64E516A2B381` (`book_id`),
  ADD KEY `IDX_50EC64E5707300A1` (`era_id`),
  ADD KEY `IDX_50EC64E54296D31F` (`genre_id`),
  ADD KEY `IDX_50EC64E5A76ED395` (`user_id`),
  ADD KEY `IDX_50EC64E5FE54D947` (`group_id`);

--
-- Index pour la table `entities_authors_assoc`
--
ALTER TABLE `entities_authors_assoc`
  ADD PRIMARY KEY (`entities_id`,`authors_id`),
  ADD KEY `IDX_C343D3456145D7DB` (`entities_id`),
  ADD KEY `IDX_C343D3456DE2013A` (`authors_id`);

--
-- Index pour la table `entities_images_assoc`
--
ALTER TABLE `entities_images_assoc`
  ADD PRIMARY KEY (`entity_id`,`image_id`),
  ADD KEY `IDX_29180181257D5D` (`entity_id`),
  ADD KEY `IDX_2918013DA5256D` (`image_id`);

--
-- Index pour la table `entities_keywords_assoc`
--
ALTER TABLE `entities_keywords_assoc`
  ADD PRIMARY KEY (`entities_id`,`keywords_id`),
  ADD KEY `IDX_26E7B8FC6145D7DB` (`entities_id`),
  ADD KEY `IDX_26E7B8FC6205D0B8` (`keywords_id`);

--
-- Index pour la table `entities_manuscripts_assoc`
--
ALTER TABLE `entities_manuscripts_assoc`
  ADD PRIMARY KEY (`entities_id`,`manuscripts_id`),
  ADD KEY `IDX_4517C18A6145D7DB` (`entities_id`),
  ADD KEY `IDX_4517C18A18DE8076` (`manuscripts_id`);

--
-- Index pour la table `entities_motifs_assoc`
--
ALTER TABLE `entities_motifs_assoc`
  ADD PRIMARY KEY (`entities_id`,`motifs_id`),
  ADD KEY `IDX_DC890C626145D7DB` (`entities_id`),
  ADD KEY `IDX_DC890C6283CAFB5D` (`motifs_id`);

--
-- Index pour la table `entities_notes_assoc`
--
ALTER TABLE `entities_notes_assoc`
  ADD PRIMARY KEY (`entities_id`,`notes_id`),
  ADD KEY `IDX_D06E50846145D7DB` (`entities_id`),
  ADD KEY `IDX_D06E5084FC56F556` (`notes_id`);

--
-- Index pour la table `entities_scholies_assoc`
--
ALTER TABLE `entities_scholies_assoc`
  ADD PRIMARY KEY (`entities_id`,`scholies_id`),
  ADD KEY `IDX_5969A6576145D7DB` (`entities_id`),
  ADD KEY `IDX_5969A657A5238A8` (`scholies_id`);

--
-- Index pour la table `entities_texts_assoc`
--
ALTER TABLE `entities_texts_assoc`
  ADD PRIMARY KEY (`entities_id`,`texts_id`),
  ADD KEY `IDX_DD309EA36145D7DB` (`entities_id`),
  ADD KEY `IDX_DD309EA39F1FF9B2` (`texts_id`);

--
-- Index pour la table `entities_translations`
--
ALTER TABLE `entities_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_9035142B81257D5D` (`entity_id`),
  ADD KEY `IDX_9035142BA76ED395` (`user_id`),
  ADD KEY `IDX_9035142BFE54D947` (`group_id`),
  ADD KEY `IDX_9035142B82F1BAF4` (`language_id`);

--
-- Index pour la table `entities_translations_align`
--
ALTER TABLE `entities_translations_align`
  ADD UNIQUE KEY `align_id` (`align_id`),
  ADD UNIQUE KEY `uniqueness` (`pair`,`user_id`) USING BTREE;

--
-- Index pour la table `eras`
--
ALTER TABLE `eras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_CF231E73A76ED395` (`user_id`),
  ADD KEY `IDX_CF231E73FE54D947` (`group_id`);

--
-- Index pour la table `eras_images_assoc`
--
ALTER TABLE `eras_images_assoc`
  ADD PRIMARY KEY (`author_id`,`image_id`),
  ADD KEY `IDX_782D2656F675F31B` (`author_id`),
  ADD KEY `IDX_782D26563DA5256D` (`image_id`);

--
-- Index pour la table `eras_translations`
--
ALTER TABLE `eras_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_E8312A7C707300A1` (`era_id`),
  ADD KEY `IDX_E8312A7CA76ED395` (`user_id`),
  ADD KEY `IDX_E8312A7CFE54D947` (`group_id`),
  ADD KEY `IDX_E8312A7C82F1BAF4` (`language_id`);

--
-- Index pour la table `fos_groups`
--
ALTER TABLE `fos_groups`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `fos_users`
--
ALTER TABLE `fos_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_32427CF792FC23A8` (`username_canonical`),
  ADD UNIQUE KEY `UNIQ_32427CF7A0D96FBF` (`email_canonical`);

--
-- Index pour la table `fos_users_groups`
--
ALTER TABLE `fos_users_groups`
  ADD PRIMARY KEY (`user_id`,`group_id`),
  ADD KEY `IDX_AC762C1DA76ED395` (`user_id`),
  ADD KEY `IDX_AC762C1DFE54D947` (`group_id`);

--
-- Index pour la table `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_A8EBE516A76ED395` (`user_id`),
  ADD KEY `IDX_A8EBE516FE54D947` (`group_id`);

--
-- Index pour la table `genres_translations`
--
ALTER TABLE `genres_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_E6A3DB174296D31F` (`genre_id`),
  ADD KEY `IDX_E6A3DB17A76ED395` (`user_id`),
  ADD KEY `IDX_E6A3DB17FE54D947` (`group_id`),
  ADD KEY `IDX_E6A3DB1782F1BAF4` (`language_id`);

--
-- Index pour la table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_E01FBE6AA76ED395` (`user_id`),
  ADD KEY `IDX_E01FBE6AFE54D947` (`group_id`);

--
-- Index pour la table `keywords`
--
ALTER TABLE `keywords`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_AA5FB55E4D95B12` (`keyword_family`),
  ADD KEY `IDX_AA5FB55EA76ED395` (`user_id`),
  ADD KEY `IDX_AA5FB55EFE54D947` (`group_id`);

--
-- Index pour la table `keywords_categories`
--
ALTER TABLE `keywords_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_8DC975ACA76ED395` (`user_id`),
  ADD KEY `IDX_8DC975ACFE54D947` (`group_id`);

--
-- Index pour la table `keywords_categories_assoc`
--
ALTER TABLE `keywords_categories_assoc`
  ADD PRIMARY KEY (`keywords_id`,`keywords_categories_id`),
  ADD KEY `IDX_4CEF4CF86205D0B8` (`keywords_id`),
  ADD KEY `IDX_4CEF4CF86D3961E` (`keywords_categories_id`);

--
-- Index pour la table `keywords_categories_translation`
--
ALTER TABLE `keywords_categories_translation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_BED32CADB0CC827` (`keyword_category_id`),
  ADD KEY `IDX_BED32CAA76ED395` (`user_id`),
  ADD KEY `IDX_BED32CAFE54D947` (`group_id`),
  ADD KEY `IDX_BED32CA82F1BAF4` (`language_id`);

--
-- Index pour la table `keywords_families`
--
ALTER TABLE `keywords_families`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_FE03935D5E237E06` (`name`);

--
-- Index pour la table `keywords_images_assoc`
--
ALTER TABLE `keywords_images_assoc`
  ADD PRIMARY KEY (`keyword_id`,`image_id`),
  ADD KEY `IDX_46ED12CB115D4552` (`keyword_id`),
  ADD KEY `IDX_46ED12CB3DA5256D` (`image_id`);

--
-- Index pour la table `keywords_translations`
--
ALTER TABLE `keywords_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D6F11EE1115D4552` (`keyword_id`),
  ADD KEY `IDX_D6F11EE1A76ED395` (`user_id`),
  ADD KEY `IDX_D6F11EE1FE54D947` (`group_id`),
  ADD KEY `IDX_D6F11EE182F1BAF4` (`language_id`);

--
-- Index pour la table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_A0D153795E237E06` (`name`);

--
-- Index pour la table `manuscripts`
--
ALTER TABLE `manuscripts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_FE81881FA76ED395` (`user_id`),
  ADD KEY `IDX_FE81881FFE54D947` (`group_id`);

--
-- Index pour la table `manuscripts_images_assoc`
--
ALTER TABLE `manuscripts_images_assoc`
  ADD PRIMARY KEY (`manuscript_id`,`image_id`),
  ADD KEY `IDX_41A68880A05723D9` (`manuscript_id`),
  ADD KEY `IDX_41A688803DA5256D` (`image_id`);

--
-- Index pour la table `manuscripts_scholies_assoc`
--
ALTER TABLE `manuscripts_scholies_assoc`
  ADD PRIMARY KEY (`manuscripts_id`,`scholies_id`),
  ADD KEY `IDX_8BFEDD9618DE8076` (`manuscripts_id`),
  ADD KEY `IDX_8BFEDD96A5238A8` (`scholies_id`);

--
-- Index pour la table `manuscripts_translations`
--
ALTER TABLE `manuscripts_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D1BA84AAA05723D9` (`manuscript_id`),
  ADD KEY `IDX_D1BA84AAA76ED395` (`user_id`),
  ADD KEY `IDX_D1BA84AAFE54D947` (`group_id`),
  ADD KEY `IDX_D1BA84AA82F1BAF4` (`language_id`);

--
-- Index pour la table `motifs`
--
ALTER TABLE `motifs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_473A7678A76ED395` (`user_id`),
  ADD KEY `IDX_473A7678FE54D947` (`group_id`);

--
-- Index pour la table `motifs_translations`
--
ALTER TABLE `motifs_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_1CF3C92D0EEB819` (`motif_id`),
  ADD KEY `IDX_1CF3C92A76ED395` (`user_id`),
  ADD KEY `IDX_1CF3C92FE54D947` (`group_id`),
  ADD KEY `IDX_1CF3C9282F1BAF4` (`language_id`);

--
-- Index pour la table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_11BA68CA76ED395` (`user_id`),
  ADD KEY `IDX_11BA68CFE54D947` (`group_id`);

--
-- Index pour la table `notes_translations`
--
ALTER TABLE `notes_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_53E21D8B26ED0855` (`note_id`),
  ADD KEY `IDX_53E21D8BA76ED395` (`user_id`),
  ADD KEY `IDX_53E21D8BFE54D947` (`group_id`),
  ADD KEY `IDX_53E21D8B82F1BAF4` (`language_id`);

--
-- Index pour la table `oauth2_access_tokens`
--
ALTER TABLE `oauth2_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_D247A21B5F37A13B` (`token`),
  ADD KEY `IDX_D247A21B19EB6921` (`client_id`),
  ADD KEY `IDX_D247A21BA76ED395` (`user_id`);

--
-- Index pour la table `oauth2_auth_codes`
--
ALTER TABLE `oauth2_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_A018A10D5F37A13B` (`token`),
  ADD KEY `IDX_A018A10D19EB6921` (`client_id`),
  ADD KEY `IDX_A018A10DA76ED395` (`user_id`);

--
-- Index pour la table `oauth2_clients`
--
ALTER TABLE `oauth2_clients`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `oauth2_refresh_tokens`
--
ALTER TABLE `oauth2_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_D394478C5F37A13B` (`token`),
  ADD KEY `IDX_D394478C19EB6921` (`client_id`),
  ADD KEY `IDX_D394478CA76ED395` (`user_id`);

--
-- Index pour la table `scholies`
--
ALTER TABLE `scholies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_E51675B9A76ED395` (`user_id`),
  ADD KEY `IDX_E51675B9FE54D947` (`group_id`);

--
-- Index pour la table `scholies_images_assoc`
--
ALTER TABLE `scholies_images_assoc`
  ADD PRIMARY KEY (`scholie_id`,`image_id`),
  ADD KEY `IDX_717488D9B06AD80` (`scholie_id`),
  ADD KEY `IDX_717488D3DA5256D` (`image_id`);

--
-- Index pour la table `scholies_translations`
--
ALTER TABLE `scholies_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_970B44A79B06AD80` (`scholie_id`),
  ADD KEY `IDX_970B44A7A76ED395` (`user_id`),
  ADD KEY `IDX_970B44A7FE54D947` (`group_id`),
  ADD KEY `IDX_970B44A782F1BAF4` (`language_id`);

--
-- Index pour la table `texts`
--
ALTER TABLE `texts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_1E3513BFA76ED395` (`user_id`),
  ADD KEY `IDX_1E3513BFFE54D947` (`group_id`);

--
-- Index pour la table `texts_translations`
--
ALTER TABLE `texts_translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_753CC2A698D3548` (`text_id`),
  ADD KEY `IDX_753CC2AA76ED395` (`user_id`),
  ADD KEY `IDX_753CC2AFE54D947` (`group_id`),
  ADD KEY `IDX_753CC2A82F1BAF4` (`language_id`);

--
-- Index pour la table `URId`
--
ALTER TABLE `URId`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D9CB8B5F81257D5D` (`entity_id`),
  ADD KEY `IDX_D9CB8B5FA76ED395` (`user_id`),
  ADD KEY `IDX_D9CB8B5FFE54D947` (`group_id`),
  ADD KEY `IDX_D9CB8B5F3CB167B5` (`urid_category_id`),
  ADD KEY `IDX_D9CB8B5FB030B09` (`urid_source_id`);

--
-- Index pour la table `URId_categories`
--
ALTER TABLE `URId_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_8FDB9DA6A76ED395` (`user_id`),
  ADD KEY `IDX_8FDB9DA6FE54D947` (`group_id`);

--
-- Index pour la table `URId_categories_translation`
--
ALTER TABLE `URId_categories_translation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_7181E11A3CB167B5` (`urid_category_id`),
  ADD KEY `IDX_7181E11AA76ED395` (`user_id`),
  ADD KEY `IDX_7181E11AFE54D947` (`group_id`),
  ADD KEY `IDX_7181E11A82F1BAF4` (`language_id`);

--
-- Index pour la table `URI_source`
--
ALTER TABLE `URI_source`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_ED14D2C2A76ED395` (`user_id`),
  ADD KEY `IDX_ED14D2C2FE54D947` (`group_id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `authors`
--
ALTER TABLE `authors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT pour la table `authors_authority`
--
ALTER TABLE `authors_authority`
  MODIFY `id_author_authority` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pour la table `author_translations`
--
ALTER TABLE `author_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `books_translations`
--
ALTER TABLE `books_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `cities_translations`
--
ALTER TABLE `cities_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `entities`
--
ALTER TABLE `entities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;
--
-- AUTO_INCREMENT pour la table `entities_translations`
--
ALTER TABLE `entities_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT pour la table `entities_translations_align`
--
ALTER TABLE `entities_translations_align`
  MODIFY `align_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT pour la table `eras`
--
ALTER TABLE `eras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `eras_translations`
--
ALTER TABLE `eras_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `fos_groups`
--
ALTER TABLE `fos_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `fos_users`
--
ALTER TABLE `fos_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT pour la table `genres`
--
ALTER TABLE `genres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `genres_translations`
--
ALTER TABLE `genres_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `images`
--
ALTER TABLE `images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pour la table `keywords`
--
ALTER TABLE `keywords`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT pour la table `keywords_categories`
--
ALTER TABLE `keywords_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `keywords_categories_translation`
--
ALTER TABLE `keywords_categories_translation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `keywords_families`
--
ALTER TABLE `keywords_families`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT pour la table `keywords_translations`
--
ALTER TABLE `keywords_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT pour la table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT pour la table `manuscripts`
--
ALTER TABLE `manuscripts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `manuscripts_translations`
--
ALTER TABLE `manuscripts_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `motifs`
--
ALTER TABLE `motifs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `motifs_translations`
--
ALTER TABLE `motifs_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `notes`
--
ALTER TABLE `notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `notes_translations`
--
ALTER TABLE `notes_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `oauth2_access_tokens`
--
ALTER TABLE `oauth2_access_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `oauth2_auth_codes`
--
ALTER TABLE `oauth2_auth_codes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `oauth2_clients`
--
ALTER TABLE `oauth2_clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `oauth2_refresh_tokens`
--
ALTER TABLE `oauth2_refresh_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `scholies`
--
ALTER TABLE `scholies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pour la table `scholies_translations`
--
ALTER TABLE `scholies_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `texts`
--
ALTER TABLE `texts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT pour la table `texts_translations`
--
ALTER TABLE `texts_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `URId`
--
ALTER TABLE `URId`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pour la table `URId_categories`
--
ALTER TABLE `URId_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `URId_categories_translation`
--
ALTER TABLE `URId_categories_translation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `URI_source`
--
ALTER TABLE `URI_source`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `authors`
--
ALTER TABLE `authors`
  ADD CONSTRAINT `FK_8E0C2A51444AED2` FOREIGN KEY (`city_born_id`) REFERENCES `cities` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_8E0C2A51707300A1` FOREIGN KEY (`era_id`) REFERENCES `eras` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_8E0C2A51A76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_8E0C2A51CB0D303` FOREIGN KEY (`city_died_id`) REFERENCES `cities` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_8E0C2A51FE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `authors_images_assoc`
--
ALTER TABLE `authors_images_assoc`
  ADD CONSTRAINT `FK_D83CC21C3DA5256D` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`),
  ADD CONSTRAINT `FK_D83CC21CF675F31B` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`);

--
-- Contraintes pour la table `author_translations`
--
ALTER TABLE `author_translations`
  ADD CONSTRAINT `FK_9835D2EA82F1BAF4` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_9835D2EAA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_9835D2EAF675F31B` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_9835D2EAFE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `FK_4A1B2A92A76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_4A1B2A92FE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `books_translations`
--
ALTER TABLE `books_translations`
  ADD CONSTRAINT `FK_1E9469D716A2B381` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_1E9469D782F1BAF4` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_1E9469D7A76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_1E9469D7FE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `FK_D95DB16BA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_D95DB16BFE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `cities_images_assoc`
--
ALTER TABLE `cities_images_assoc`
  ADD CONSTRAINT `FK_1AAFF0D23DA5256D` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`),
  ADD CONSTRAINT `FK_1AAFF0D28BAC62AF` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`);

--
-- Contraintes pour la table `cities_translations`
--
ALTER TABLE `cities_translations`
  ADD CONSTRAINT `FK_8AB3FCF882F1BAF4` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_8AB3FCF88BAC62AF` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_8AB3FCF8A76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_8AB3FCF8FE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `entities`
--
ALTER TABLE `entities`
  ADD CONSTRAINT `FK_50EC64E516A2B381` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `FK_50EC64E54296D31F` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`),
  ADD CONSTRAINT `FK_50EC64E5707300A1` FOREIGN KEY (`era_id`) REFERENCES `eras` (`id`),
  ADD CONSTRAINT `FK_50EC64E5A76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_50EC64E5FE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `entities_authors_assoc`
--
ALTER TABLE `entities_authors_assoc`
  ADD CONSTRAINT `FK_C343D3456145D7DB` FOREIGN KEY (`entities_id`) REFERENCES `entities` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_C343D3456DE2013A` FOREIGN KEY (`authors_id`) REFERENCES `authors` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `entities_images_assoc`
--
ALTER TABLE `entities_images_assoc`
  ADD CONSTRAINT `FK_2918013DA5256D` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`),
  ADD CONSTRAINT `FK_29180181257D5D` FOREIGN KEY (`entity_id`) REFERENCES `entities` (`id`);

--
-- Contraintes pour la table `entities_keywords_assoc`
--
ALTER TABLE `entities_keywords_assoc`
  ADD CONSTRAINT `FK_26E7B8FC6145D7DB` FOREIGN KEY (`entities_id`) REFERENCES `entities` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_26E7B8FC6205D0B8` FOREIGN KEY (`keywords_id`) REFERENCES `keywords` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `entities_manuscripts_assoc`
--
ALTER TABLE `entities_manuscripts_assoc`
  ADD CONSTRAINT `FK_4517C18A18DE8076` FOREIGN KEY (`manuscripts_id`) REFERENCES `manuscripts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_4517C18A6145D7DB` FOREIGN KEY (`entities_id`) REFERENCES `entities` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `entities_motifs_assoc`
--
ALTER TABLE `entities_motifs_assoc`
  ADD CONSTRAINT `FK_DC890C626145D7DB` FOREIGN KEY (`entities_id`) REFERENCES `entities` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_DC890C6283CAFB5D` FOREIGN KEY (`motifs_id`) REFERENCES `motifs` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `entities_notes_assoc`
--
ALTER TABLE `entities_notes_assoc`
  ADD CONSTRAINT `FK_D06E50846145D7DB` FOREIGN KEY (`entities_id`) REFERENCES `entities` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_D06E5084FC56F556` FOREIGN KEY (`notes_id`) REFERENCES `notes` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `entities_scholies_assoc`
--
ALTER TABLE `entities_scholies_assoc`
  ADD CONSTRAINT `FK_5969A6576145D7DB` FOREIGN KEY (`entities_id`) REFERENCES `entities` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_5969A657A5238A8` FOREIGN KEY (`scholies_id`) REFERENCES `scholies` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `entities_texts_assoc`
--
ALTER TABLE `entities_texts_assoc`
  ADD CONSTRAINT `FK_DD309EA36145D7DB` FOREIGN KEY (`entities_id`) REFERENCES `entities` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_DD309EA39F1FF9B2` FOREIGN KEY (`texts_id`) REFERENCES `texts` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `entities_translations`
--
ALTER TABLE `entities_translations`
  ADD CONSTRAINT `FK_9035142B81257D5D` FOREIGN KEY (`entity_id`) REFERENCES `entities` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_9035142B82F1BAF4` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_9035142BA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_9035142BFE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `eras`
--
ALTER TABLE `eras`
  ADD CONSTRAINT `FK_CF231E73A76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_CF231E73FE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `eras_images_assoc`
--
ALTER TABLE `eras_images_assoc`
  ADD CONSTRAINT `FK_782D26563DA5256D` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`),
  ADD CONSTRAINT `FK_782D2656F675F31B` FOREIGN KEY (`author_id`) REFERENCES `eras` (`id`);

--
-- Contraintes pour la table `eras_translations`
--
ALTER TABLE `eras_translations`
  ADD CONSTRAINT `FK_E8312A7C707300A1` FOREIGN KEY (`era_id`) REFERENCES `eras` (`id`),
  ADD CONSTRAINT `FK_E8312A7C82F1BAF4` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`),
  ADD CONSTRAINT `FK_E8312A7CA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_E8312A7CFE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `fos_users_groups`
--
ALTER TABLE `fos_users_groups`
  ADD CONSTRAINT `FK_AC762C1DA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`),
  ADD CONSTRAINT `FK_AC762C1DFE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`);

--
-- Contraintes pour la table `genres`
--
ALTER TABLE `genres`
  ADD CONSTRAINT `FK_A8EBE516A76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_A8EBE516FE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `genres_translations`
--
ALTER TABLE `genres_translations`
  ADD CONSTRAINT `FK_E6A3DB174296D31F` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_E6A3DB1782F1BAF4` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_E6A3DB17A76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_E6A3DB17FE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `FK_E01FBE6AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_E01FBE6AFE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `keywords`
--
ALTER TABLE `keywords`
  ADD CONSTRAINT `FK_AA5FB55E4D95B12` FOREIGN KEY (`keyword_family`) REFERENCES `keywords_families` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_AA5FB55EA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_AA5FB55EFE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `keywords_categories`
--
ALTER TABLE `keywords_categories`
  ADD CONSTRAINT `FK_8DC975ACA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_8DC975ACFE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `keywords_categories_assoc`
--
ALTER TABLE `keywords_categories_assoc`
  ADD CONSTRAINT `FK_4CEF4CF86205D0B8` FOREIGN KEY (`keywords_id`) REFERENCES `keywords` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_4CEF4CF86D3961E` FOREIGN KEY (`keywords_categories_id`) REFERENCES `keywords_categories` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `keywords_categories_translation`
--
ALTER TABLE `keywords_categories_translation`
  ADD CONSTRAINT `FK_BED32CA82F1BAF4` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_BED32CAA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_BED32CADB0CC827` FOREIGN KEY (`keyword_category_id`) REFERENCES `keywords_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_BED32CAFE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `keywords_images_assoc`
--
ALTER TABLE `keywords_images_assoc`
  ADD CONSTRAINT `FK_46ED12CB115D4552` FOREIGN KEY (`keyword_id`) REFERENCES `keywords` (`id`),
  ADD CONSTRAINT `FK_46ED12CB3DA5256D` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`);

--
-- Contraintes pour la table `keywords_translations`
--
ALTER TABLE `keywords_translations`
  ADD CONSTRAINT `FK_D6F11EE1115D4552` FOREIGN KEY (`keyword_id`) REFERENCES `keywords` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_D6F11EE182F1BAF4` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_D6F11EE1A76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_D6F11EE1FE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `manuscripts`
--
ALTER TABLE `manuscripts`
  ADD CONSTRAINT `FK_FE81881FA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_FE81881FFE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `manuscripts_images_assoc`
--
ALTER TABLE `manuscripts_images_assoc`
  ADD CONSTRAINT `FK_41A688803DA5256D` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`),
  ADD CONSTRAINT `FK_41A68880A05723D9` FOREIGN KEY (`manuscript_id`) REFERENCES `manuscripts` (`id`);

--
-- Contraintes pour la table `manuscripts_scholies_assoc`
--
ALTER TABLE `manuscripts_scholies_assoc`
  ADD CONSTRAINT `FK_8BFEDD9618DE8076` FOREIGN KEY (`manuscripts_id`) REFERENCES `manuscripts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_8BFEDD96A5238A8` FOREIGN KEY (`scholies_id`) REFERENCES `scholies` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `manuscripts_translations`
--
ALTER TABLE `manuscripts_translations`
  ADD CONSTRAINT `FK_D1BA84AA82F1BAF4` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_D1BA84AAA05723D9` FOREIGN KEY (`manuscript_id`) REFERENCES `manuscripts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_D1BA84AAA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_D1BA84AAFE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `motifs`
--
ALTER TABLE `motifs`
  ADD CONSTRAINT `FK_473A7678A76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_473A7678FE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `motifs_translations`
--
ALTER TABLE `motifs_translations`
  ADD CONSTRAINT `FK_1CF3C9282F1BAF4` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_1CF3C92A76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_1CF3C92D0EEB819` FOREIGN KEY (`motif_id`) REFERENCES `motifs` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_1CF3C92FE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `notes`
--
ALTER TABLE `notes`
  ADD CONSTRAINT `FK_11BA68CA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_11BA68CFE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `notes_translations`
--
ALTER TABLE `notes_translations`
  ADD CONSTRAINT `FK_53E21D8B26ED0855` FOREIGN KEY (`note_id`) REFERENCES `notes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_53E21D8B82F1BAF4` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_53E21D8BA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_53E21D8BFE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `oauth2_access_tokens`
--
ALTER TABLE `oauth2_access_tokens`
  ADD CONSTRAINT `FK_D247A21B19EB6921` FOREIGN KEY (`client_id`) REFERENCES `oauth2_clients` (`id`),
  ADD CONSTRAINT `FK_D247A21BA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`);

--
-- Contraintes pour la table `oauth2_auth_codes`
--
ALTER TABLE `oauth2_auth_codes`
  ADD CONSTRAINT `FK_A018A10D19EB6921` FOREIGN KEY (`client_id`) REFERENCES `oauth2_clients` (`id`),
  ADD CONSTRAINT `FK_A018A10DA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`);

--
-- Contraintes pour la table `oauth2_refresh_tokens`
--
ALTER TABLE `oauth2_refresh_tokens`
  ADD CONSTRAINT `FK_D394478C19EB6921` FOREIGN KEY (`client_id`) REFERENCES `oauth2_clients` (`id`),
  ADD CONSTRAINT `FK_D394478CA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`);

--
-- Contraintes pour la table `scholies`
--
ALTER TABLE `scholies`
  ADD CONSTRAINT `FK_E51675B9A76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_E51675B9FE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `scholies_images_assoc`
--
ALTER TABLE `scholies_images_assoc`
  ADD CONSTRAINT `FK_717488D3DA5256D` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`),
  ADD CONSTRAINT `FK_717488D9B06AD80` FOREIGN KEY (`scholie_id`) REFERENCES `scholies` (`id`);

--
-- Contraintes pour la table `scholies_translations`
--
ALTER TABLE `scholies_translations`
  ADD CONSTRAINT `FK_970B44A782F1BAF4` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_970B44A79B06AD80` FOREIGN KEY (`scholie_id`) REFERENCES `scholies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_970B44A7A76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_970B44A7FE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `texts`
--
ALTER TABLE `texts`
  ADD CONSTRAINT `FK_1E3513BFA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_1E3513BFFE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `texts_translations`
--
ALTER TABLE `texts_translations`
  ADD CONSTRAINT `FK_753CC2A698D3548` FOREIGN KEY (`text_id`) REFERENCES `texts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_753CC2A82F1BAF4` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_753CC2AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_753CC2AFE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `URId`
--
ALTER TABLE `URId`
  ADD CONSTRAINT `FK_D9CB8B5F3CB167B5` FOREIGN KEY (`urid_category_id`) REFERENCES `URId_categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_D9CB8B5F81257D5D` FOREIGN KEY (`entity_id`) REFERENCES `entities` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_D9CB8B5FA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_D9CB8B5FB030B09` FOREIGN KEY (`urid_source_id`) REFERENCES `URI_source` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_D9CB8B5FFE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `URId_categories`
--
ALTER TABLE `URId_categories`
  ADD CONSTRAINT `FK_8FDB9DA6A76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_8FDB9DA6FE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `URId_categories_translation`
--
ALTER TABLE `URId_categories_translation`
  ADD CONSTRAINT `FK_7181E11A3CB167B5` FOREIGN KEY (`urid_category_id`) REFERENCES `URId_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_7181E11A82F1BAF4` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_7181E11AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_7181E11AFE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `URI_source`
--
ALTER TABLE `URI_source`
  ADD CONSTRAINT `FK_ED14D2C2A76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_ED14D2C2FE54D947` FOREIGN KEY (`group_id`) REFERENCES `fos_groups` (`id`) ON DELETE SET NULL;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
