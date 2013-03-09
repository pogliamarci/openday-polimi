-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 09, 2013 at 11:29 AM
-- Server version: 5.1.44
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `my_movies`
--

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--

CREATE TABLE IF NOT EXISTS `movie` (
  `index` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `actors` varchar(800) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`index`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Dumping data for table `movie`
--

INSERT INTO `movie` (`index`, `title`, `actors`, `price`) VALUES
(1, '007 Skyfall', 'Daniel Craig, Javier Bardem, Judi Dench e Ralph Fiennes', 1261),
(2, 'Argo', 'Ben Affleck, Bryan Cranston, Alan Arkin e John Goodman', 1410),
(4, 'Quasi Amici', 'Francois Cluzet, Omar Sy, Anne Le Ny e Audrey Fleurot', 790),
(5, 'Le Belve (2012)', 'Taylor Kitsch, Blake Lively, Aaron Taylor-Johnson, e al.', 1187),
(6, 'Bastardi Senza Gloria', 'Samuel L. Jackson, Brad Pitt, Christoph Waltz e Eli Roth', 790),
(7, 'Ted', 'Mark Wahlberg, Mila Kunis, Seth MacFarlane, e al.', 1124),
(8, 'The Help', 'Emma Stone, Viola Davis, Bryce Dallas Howard, e al.', 891),
(9, 'Taken - La Vendetta', 'Liam Neeson, Maggie Grace, Leland Orser e Framke Jannsen', 1128),
(10, 'Un Sapore Di Ruggine E Ossa', 'Marion Cotillard, Matthias Schoenaerts, Armand Verdure, e al.', 1286),
(11, 'Habemus Papam', 'Nanni Moretti, Michel Piccoli, Roberto Nobile, e al.', 692),
(12, 'Harry Potter E I Doni Della Morte - Parte 2', 'Daniel Radcliffe, Michael Gambon, Helena Bonham Carter, e al.', 692),
(13, 'On The Road', 'Garrett Hedlund, Sam Riley, Kristen Stewart e Amy Adams', 1266),
(14, 'Django Unchained', 'Leonardo Di Caprio, Samuel L. Jackson, Jamie Foxx, e al.', 1485),
(15, 'Il Cavaliere Oscuro - Il Ritorno', 'Christian Bale, Michael Caine, Gary Oldman, e al.', 1475),
(16, 'Hunger Games', 'Jennifer Lawrence, Josh Hutcherson, Liam Hemsworth, e al.', 841),
(17, 'Bella Addormentata', 'Toni Servillo, Isabelle Huppert, Alba Rohrwacher, e a', 1113),
(18, 'Dark Shadows', 'Johnny Depp, Michelle Pfeiffer, Helena Bonham-Carter, e al.', 841),
(19, 'Sherlock Holmes - Gioco Di Ombre', 'Robert Downey Jr., Jude Law, Noomi Rapace e Stephen Fry', 891),
(20, 'Inception', 'Leonardo DiCaprio, Ken Watanabe, Joseph Gordon-Levitt, e al.', 782),
(21, 'Moneyball - L''Arte Di Vincere', 'Brad Pitt, Jonah Hill, Philip Seymour Hoffman, e al', 623);
