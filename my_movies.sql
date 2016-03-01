DROP DATABASE IF EXISTS `my_movies`;
CREATE DATABASE `my_movies` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

USE `my_movies`;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `isAdmin` bool DEFAULT 0 NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `movie`;
CREATE TABLE `movie` (
  `index` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET latin1 NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `actors` text COLLATE utf8_unicode_ci,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `movie_id` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8_unicode_ci,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `user_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `quantity` int(11) NOT NULL DEFAULT '0',
  KEY `pk` (`user_id`,`movie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

GRANT ALL ON `my_movies`.* TO 'vuln-user'@'localhost';
DROP USER 'vuln-user'@'localhost';
CREATE USER 'vuln-user'@'localhost' IDENTIFIED BY 'vuln-pass';
GRANT ALL ON `my_movies`.* TO 'vuln-user'@'localhost';

INSERT INTO `users` (`username`, `password`) VALUES ('stefano','stefano'), ('eros','eros'), ('fabio', 'fabio'), ('andrea', 'andrea'), ('federico', 'federico'), ('mario', 'mario'), ('john', 'mich');

INSERT INTO `users` (`username`, `password`, `isAdmin`) VALUES ('admin','tipiacerebbesapere la passworddiadmin',1);

INSERT INTO `movie` (`index`, `title`, `description`, `actors`, `price`) VALUES
(1, '007 Skyfall', 										'La lealtà di James Bond verso M (Judi Dench) è messa a dura prova quando il passato della donna torna a perseguitarla. E mentre l\'M6 è sotto attacco, l\'agente 007 deve scovare e distruggere la minaccia a tutti i costi, anche personali.', 'Daniel Craig, Javier Bardem, Judi Dench e Ralph Fiennes', 1261),
(2, 'Argo', 											'Il 4 novembre 1979, mentre la rivoluzione iraniana raggiungeva l\'apice, un gruppo di militanti entra nell\'Ambasciata USA in Tehran e porta via 52 ostaggi. In mezzo al caos, sei americani riescono a fuggire e si rifugiano a casa dell\'Ambasciatore del Canada. Ben sapendo che si tratta solo di questione di tempo prima che i sei vangano rintracciati e molto probabilmente uccisi, Tony Mendez, un agente della CIA specialista in azioni d\'infiltrazione, mette in piedi un piano rischioso per farli scappare dal paese. Un piano così inverosimile che potrebbe accadere solo nei film.', 'Ben Affleck, Bryan Cranston, Alan Arkin e John Goodman', 1410),
(4, 'Quasi Amici', 										'Quasi amici, ispirato ad una storia vera, racconta l\'incontro tra due mondi apparentemente lontani. Dopo un incidente di parapendio che lo ha reso paraplegico, il ricco aristocratico Philippe assume Driss, ragazzo di periferia appena uscito dalla prigione, come badante personale. Per dirla senza troppi giri di parole, la persona meno adatta per questo incarico. L\'improbabile connubio genera altrettanto improbabili incontri tra Vivaldi e gli Earth, Wind and Fire, dizione perfetta e slang di strada, completi eleganti e tute da ginnastica. Due universi opposti entrano in rotta di collisione ma per quanto strano possa sembrare prima dello scontro finale troveranno un punto d\'incontro che sfocerà in un’amicizia folle, comica, profonda quanto inaspettata.', 'Francois Cluzet, Omar Sy, Anne Le Ny e Audrey Fleurot', 790),
(5, 'Le Belve (2012)', 									'Due imprenditori di Laguna Beach, Ben, pacifico e caritatevole buddista, e il suo migliore amico Chon, ex Navy Seal ed ex mercenario, conducono una lucrativa attività fatta in casa, producendo la migliore marijuana mai coltivata prima d\'ora. Condividono inoltre un amore unico nel suo genere per la bellissima Ophelia. La vita è idilliaca nella loro cittadina nel sud della California, almeno fino a quando il cartello dei trafficanti della Mexican Baja decide di irrompere nei loro piani imponendosi come socio. Quando Elena, lo spietato capo del cartello, e Lado, il suo scagnozzo, sottovalutano l\'infrangibile legame che tiene uniti i tre amici, Ben e Chon, attraverso l\'ambiguo aiuto di un viscido agente della DEA, scatenano una battaglia, a prima vista già persa, contro il cartello. Così hanno inizio una serie di piani e manovre ad alto rischio.', 'Taylor Kitsch, Blake Lively, Aaron Taylor-Johnson, e al.', 1187),
(6, 'Bastardi Senza Gloria', 							'Nella Francia occupata dai nazisti, Shosanna Dreyfus (Mélanie Laurent) assiste all’uccisione di tutta la sua famiglia per mano del colonnello nazista Hans Landa (Christoph Waltz). Shosanna risce a sfuggire miracolosamente alla morte e si rifugia a Parigi, dove assume una nuova identità e diviene proprietaria di una sala cinematografica. Altrove in Europa, il tenente Aldo Raine (Brad Pitt) mette assieme una squadra speciale di soldati ebrei : noti come \"The Basterds\", i soldati vengono incaricati dai loro superiori di agire come cani sciolti sul territorio uccidendo ogni soldato tedesco che incontrano e prendendogli lo scalpo. La squadra di Raine di troverà a collaborare con l’attrice tedesca Bridget Von Hammersmark (Diane Kruger), una spia degli Alleati, in una missione che mira ad eliminare i leader del Terzo Reich. La loro missione li porterà nei pressi del cinema parigino dove Shosanna sta tramando un piano di vendetta privata… Inglorious Bastards, progetto covato da anni da Quentin Tarantino, è ispirato da uno dei cult-movie per eccellenza del regista americano, Quel maledetto treno blindato di Enzo G. Castellari.', 'Samuel L. Jackson, Brad Pitt, Christoph Waltz e Eli Roth', 790),
(7, 'Ted', 												'John è un ragazzino senza amici, che nel giorno di Natale esprime il desiderio che l\'orso di peluche che i suoi gli hanno regalato diventi vero. La magia avviene, e nel corso degli anni John e Ted restano inseparabili. Ma quando quest\'ultimo inizia a diventare un problema nei rapporti tra John e l\'amatissima fidanzata Lori, si renderà necessaria una scelta. Dall\'autore dei Griffin e American Dad, Seth MacFarlane, arriva una commedia sull\'immaturità e l\'amicizia, con l\'orsacchiottone più ribaldo, simpatico e mattoide della storia del cinema.', 'Mark Wahlberg, Mila Kunis, Seth MacFarlane, e al.', 1124),
(8, 'The Help', 										'Ambientata a Jackson, Mississippi, nei primi anni Sessanta, la storia esplora i temi del razzismo e del perbenismo di facciata delle famiglie del Sud, quando una aspirante scrittrice intervista una cameriera che racconta la verità sulle sue esperienze nelle case dei bianchi.', 'Emma Stone, Viola Davis, Bryce Dallas Howard, e al.', 891),
(9, 'Taken - La Vendetta', 								'Nel sequel di Io vi troverò, l\'ex agente operativo della CIA Bryan Mills (Liam Neeson) è a Istanbul, dove viene raggiunto a sorpresa dall\'ex moglie Lenore (Famke Jannsen) e dalla figlia Kim (Maggie Grace), per quella che sembra poter essere una tranquilla vacanza. Ma non lo sarà, perché il padre di uno dei criminali che quattro anni prima avevano rapito la figlia è in cerca di vendetta. Questa volta è Lenore a cadere nelle mani dei sequestratori e Mills, con l\'aiuto di Kim, dovrà affrontare una nuova corsa contro il tempo per salvare la sua famiglia e se stesso dalla sete di sangue del suo nuovo nemico.', 'Liam Neeson, Maggie Grace, Leland Orser e Framke Jannsen', 1128),
(10, 'Un Sapore Di Ruggine E Ossa', 					'Tutto ha inizio al Nord. Ali si ritrova solo con Sam, 5 anni. E\' suo figlio, ma lo conosce appena. Senza fissa dimora, senza soldi, senza amici, Ali decide di trovare rifugio presso suo sorella a Antibes, nel Sud della Francia. Lì le cose vanno decisamente meglio. Ali e suo figlio vengono ospitati dalla donna. Lei si occupa del bambino. Il tempo è bello. Dopo una rissa in un locale notturno, il destino di Ali incrocia quello di Stéphanie. Lui la riaccompagna a casa e le lascia il suo numero di telefono. Lui è povero, lei è bella e sicura di sé. E\' una principessa. Non hanno niente in comune. Stéphanie addestra orche a Marineland. Ci vorrà una tragedia per farli incontrare di nuovo. Quando Ali la rivede, la principessa è costretta su una sedia a rotelle: ha perso le gambe e tutte le sue illusioni.', 'Marion Cotillard, Matthias Schoenaerts, Armand Verdure, e al.', 1286),
(11, 'Habemus Papam', 									'Il film si apre alla morte del Pontefice e e con il Conclave che deve eleggere un nuovo Papa. Ma il neoeletto (Michel Piccoli) è preda dei dubbi e delle ansie, depresso e timoroso di non essere in grado di assolvere il suo compito. Il Vaticano chiama allora uno psicanalista (Nanni Moretti) perché lo assista e lo aiuti a superare i suoi problemi.', 'Nanni Moretti, Michel Piccoli, Roberto Nobile, e al.', 692),
(12, 'Harry Potter E I Doni Della Morte - Parte 2', 	'Harry, Ron ed Hermione organizzano un furto alla Gringott, la banca dei maghi, dove è nascosto uno degli Horcrux rimasti. Benché lo recuperino sono costretti a fuggire, e lo fanno in grande stile, liberando un drago dalle segrete della banca. Ed è in groppa a lui che si dirigono ad Hogwarts, pronti a distruggere gli ultimi due Horcrux rimasti e sconfiggere definitivamente Lord Voldemort che radunerà nella scuola tutto il suo esercito scontrandosi contro gli studenti e l\'Ordine della Fenice. La battaglia finale ha così inizio, portando con se i caduti e le straordinarie rivelazioni conclusive.', 'Daniel Radcliffe, Michael Gambon, Helena Bonham Carter, e al.', 692),
(13, 'On The Road', 									'Dopo la morte del padre, Sal Paradise un aspirante scrittore newyorchese, incontra Dean Moriarty, giovane ex-pregiudicato dal fascino maledetto, sposato con la disinibita e seducente Marylou. Tra Sal e Dean l\'intesa è immediata e simbiotica. Decisi a non farsi rinchiudere in una vita vissuta secondo le regole, i due amici rompono tutti i legami e si mettono in viaggio con Marylou. Assetati di libertà, i tre giovani partono alla scoperta del mondo, degli altri e di loro stessi.', 'Garrett Hedlund, Sam Riley, Kristen Stewart e Amy Adams', 1266),
(14, 'Django Unchained', 								'Ambientato nel Sud degli attuali Stati Uniti, due anni prima dello scoppio della Guerra Civile, Django Unchained vede protagonista Jamie Foxx nel ruolo di Django, uno schiavo la cui storia brutale con il suo ex padrone, lo conduce faccia a faccia con il cacciatore di taglie di origine tedesca, il Dott. King Schultz (Christoph Waltz). Schultz è sulle tracce degli assassini fratelli Brittle, e solo l’aiuto di Django lo porterà a riscuotere la taglia che pende sulle loro teste. Il poco ortodosso Schultz assolda Django con la promessa di donargli la libertà una volta catturati i Brittle - vivi o morti. Il successo dell’operazione induce Schultz a liberare Django, sebbene i due uomini scelgano di non separarsi. Al contrario, Schultz parte alla ricerca dei criminali più ricercati del Sud con Django al suo fianco. Affinando vitali abilità di cacciatore, Django resta concentrato su un solo obiettivo: trovare e salvare Broomhilda (Kerry Washington), la moglie che aveva perso tempo prima, a causa della sua vendita come schiavo.', 'Leonardo Di Caprio, Samuel L. Jackson, Jamie Foxx, e al.', 1485),
(15, 'Il Cavaliere Oscuro - Il Ritorno', 				'Sono passati otto anni da quando Batman è svanito nella notte, trasformandosi in quell\'istante da eroe a fuggiasco. Prendendosi la colpa della morte del procuratore distrettuale Harvey Dent, il Cavaliere oscuro ha sacrificato tutto per ciò che lui e il Commissario Gordon speravano fosse un bene superiore. Per un po\' di tempo la bugia ha funzionato, in quanto l\'attività criminale a Gotham City è stata schiacciata dal peso del Dent Act, una legge anti crimine. Ma tutto cambierà con l\'arrivo di una astuta ladra con uno strano piano in mente. Molto più pericoloso, comunque, è l\'arrivo di Bane, un terrorista mascherato i cui spietati piani per Gotham portano Bruce a uscire dal suo esilio auto-imposto. Ma anche se indossa nuovamente il mantello e il cappuccio, Batman potrebbe non essere abbastanza forte per fermare Bane.', 'Christian Bale, Michael Caine, Gary Oldman, e al.', 1475),
(16, 'Hunger Games', 									'Ogni anno tra le rovine di quello che fu il Nord America, lo stato di Panem obbliga ognuno dei suoi dodici distretti a mandare un ragazzo e una ragazza a competere agli Hunger Games. In parte bizzarro spettacolo, in parte stratagemma intimidatorio del Governo, gli Hunger Games sono un evento televisivo nazionale nel quale i \"Tributi\" devono combattere gli uni con gli altri per la sopravvivenza. Contrapposta ai Tributi ben allenati che si sono preparati agli Hunger Games per tutta la vita, Katniss è costretta a contare sul suo brillante istinto oltre che sull\'addestramento di un precedente vincitore dei giochi, l\'alcolizzato Haymitch Abernathy. Per tornare a casa al Distretto 12, Katniss deve fare scelte impossibili nell\'arena, che metteranno sulla bilancia la sopravvivenza contro l\'umanità e la vita e contro l\'amore.', 'Jennifer Lawrence, Josh Hutcherson, Liam Hemsworth, e al.', 841),
(17, 'Bella Addormentata', 								'Un senatore deve scegliere se votare per una legge che va contro la sua coscienza o non votarla, disubbidendo alla disciplina del partito, mentre sua figlia Maria, attivista del movimento per la vita, manifesta davanti alla clinica dove è ricoverata Eluana.Roberto, con il fratello, è schierato nell\'opposto fronte laico. Un \"nemico\" di cui Maria si innamora. Altrove, una grande attrice cerca nella fede e nel miracolo la guarigione della figlia, da anni in coma irreversibile, sacrificando così il rapporto con il figlio. Infine la disperata Rossa che vuole morire, ma un giovane medico di nome Pallido si oppone con tutte le forze al suo suicidio. E contro ogni aspettativa, alla fine del film, un risveglio alla vita...', 'Toni Servillo, Isabelle Huppert, Alba Rohrwacher, e a', 1113),
(18, 'Dark Shadows', 									'Nell\'anno 1752, Joshua e Naomi Collins, insieme al loro giovane figlio Barnabas, salpano da Liverpool, Inghilterra, per cominciare una nuova vita in America. Ma anche un oceano non basta per sfuggire alla misteriosa maledizione che affligge la famiglia. Due decenni passano e Barnabas ha il mondo ai suoi piedi, o almeno la città di Collinsport, Maine. Barnabas, signore di Collinwood Manor, è ricco, potente e un esperto playboy, finché non commette il terribile errore di spezzare il cuore di Angelique Brouchard (Eva Green). Una strega in tutti i sensi, Angelique lo condanna a un destino peggiore della morte, trasformandolo in vampiro e seppellendolo vivo. Due secoli più tardi, Barnabas viene liberato involontariamente dalla sua tomba ed emerge nel diversissimo mondo del 1972. Tornato a Collinwood Manor, scopre che la sua un tempo grande proprietà è caduta in rovina. Ciò che rimane della famiglia Collins se la passa poco meglio, e ciascuno nasconde oscuri segreti.', 'Johnny Depp, Michelle Pfeiffer, Helena Bonham-Carter, e al.', 841),
(19, 'Sherlock Holmes - Gioco Di Ombre', 				'Nel film Sherlock Holmes 2, una nuova acuta mente criminale, il Professor Moriarty, con una intelligenza pari a quella di Holmes e con una predisposizione al male ed una totale assenza di coscienza, potrebbe mettere in grande difficoltà il rinomato detective. Quando il Principe d\'Austria viene trovato morto, tutte le prove raccolte dall\'Ispettore Lestrade, indicano come causa della morte il suicidio. Eppure Sherlock Holmes deduce che il Principe è stato vittima di un omicidio, un omicidio che è soltanto il primo pezzo di un puzzle ben più grande e sinistro messo a punto dal Professor Moriarty.', 'Robert Downey Jr., Jude Law, Noomi Rapace e Stephen Fry', 891),
(20, 'Inception', 										'Dom Cobb (Leonardo Di Caprio) è un abilissimo ladro, il migliore al mondo quando di tratta della pericolosa arte dell\'estrazione: ovvero il furto di preziosi segreti dal profondo del subconscio mentre si sogna, quando la mente è al massimo della sua vulnerabilità. Le abilità di Cobb ne hanno fatto un giocatore di primo piano nel pericoloso mondo dello spionaggio industriale, ma lo hanno reso un fuggitivo ricercato in tutto il mondo. Ma ora Cobb ha una chance di redenzione, ma solo se riuscirà a rendere possibile l\'impossibile.', 'Leonardo DiCaprio, Ken Watanabe, Joseph Gordon-Levitt, e al.', 782),
(21, 'Moneyball - L''Arte Di Vincere', 					'Assunto come general manager della squadra di baseball degli Oakland\'s Athletics, Billy Beane cerca di trovare in un complesso sistema computerizzato d\'analisi statistica il modo di trovare i giocatori migliori da mettere sotto contratto e da schierare. Per tornare finalmente a vincere.', 'Brad Pitt, Jonah Hill, Philip Seymour Hoffman, e al', 623);


