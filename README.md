# UNO Card Game

[https://users.iee.ihu.gr/~it144242/ADISE19-Uno-Game](https://users.iee.ihu.gr/~it144242/ADISE19-Uno-Game "UNO GAME")

------
# Περιγραφή Παιχνιδιού

Το Uno ('ένα' στα ιταλικά) είναι παιχνίδι καρτών, παρόμοιο σε φιλοσοφία με τη δική μας ‘αγωνία‘ [που παίζεται με τράπουλα]. Η τράπουλα του Uno αποτελείται από κάρτες τεσσάρων χρωμάτων (κόκκινες, πράσινες, κίτρινες και μπλε) καθώς και από ειδικές κάρτες.
___

__Συγκεκριμένα:__

Kάθε  χρώμα έχει κάρτες με αριθμούς από το 0 ως και το 9 και κάρτες 'πάρε δύο' , 'χάνεις τη σειρά σου' , 'αλλαγή φοράς' (οι τρεις τελευταίοι τύποι κάρτας λέγονται 'κάρτες δράσης').

Όλες αυτές υπάρχουν από δύο φορές μες την τράπουλα ανά χρώμα, εκτός του αριθμού __0__ που υπάρχει μόνο μία φορά ανά χρώμα.

Επίσης υπάρχουν και δύο τύποι ειδικών καρτών: ο ‘μπαλαντέρ’ και ο ‘μπαλαντέρ πάρε τέσσερα’, τέσσερις από τον καθένα.

Συνολικά όλες οι κάρτες είναι 108.
___

__Πώς παίζεται:__

Η τράπουλα ανακατεύεται και σε κάθε παίχτη μοιράζονται 7 κάρτες. Πρώτος παίζει αυτός που κάθεται αριστερά αυτού που μοίρασε και η σειρά με την οποία παίζουν οι παίχτες είναι η φορά των δεικτών του ρολογιού.

Η επάνω κάρτα της στοίβας των καρτών που δεν μοιράστηκαν στους παίχτες, τοποθετείται ανοιχτή στο κέντρο του τραπεζιού μπροστά σε όλους τους παίχτες και είναι η πρώτη του σωρού των χρησιμοποιημένων καρτών.

Ο πρώτος στη σειρά παίχτης πρέπει να ρίξει μια κάρτα ίδιου αριθμού ή χρώματος με την κάρτα αυτή ή να πετάξει μια ειδική κάρτα. Σε περίπτωση που  δεν έχει καμία κάρτα να ταιριάξει με την πάνω κάρτα του σωρού, πρέπει να τραβήξει μια κάρτα από τη στοίβα και αν ούτε τότε δεν έχει να παίξει, πηγαίνει πάσο και έρχεται η σειρά του επόμενου παίχτη να παίξει, ακολουθώντας πάντα το ίδιο μοτίβο επιτρεπτών επιλογών [χρώμα ή αριθμός – ειδική κάρτα – κάρτα από τη στοίβα – πάσο]

Σκοπός του παιχνιδιού για κάθε παίχτη είναι να ξεφορτωθεί όλες τις κάρτες που έχει στα χέρια του. Ο πρώτος που θα τα καταφέρει ανακηρύσσεται νικητής για το γύρο αυτό.
___

__Κάρτες:__

__χάνεις τη σειρά σου κάρτα:__ ο επόμενος παίχτης χάνει τη σειρά του και παίζει ο μεθεπόμενος.

__πάρε δύο:__ ο επόμενος παίχτης παίρνει δύο κάρτες από τη στοίβα και χάνει τη σειρά του.

__αλλαγή φοράς:__ αν αυτή η κάρτα παιχτεί, τότε ο επόμενος παίχτης που παίζει είναι ο προηγούμενος αυτού που την έριξε και η σειρά με την οποία παίζουν οι παίχτες αντιστρέφεται [και μπορεί να επανέλθει μόνο όταν ριχτεί ξανά η κάρτα αυτή στο σωρό].

__μπαλαντέρ:__ όποιος τη ρίξει, αποφασίζει για το χρώμα το οποίο θα έχουν οι κάρτες που θα ρίχνονται στο σωρό και ο επόμενος παίχτης χάνει την σειρά του.

__μπαλαντέρ πάρε τέσσερα:__ όποιος ρίξει την κάρτα αυτή, διαλέγει το χρώμα που θα έχουν οι κάρτες που θα πέφτουν στο σωρό ενώ αναγκάζει τον επόμενο παίχτη να πάρει τέσσερις κάρτες και να χάσει τη σειρά του.
___

# Βάση UNO
## Deck
___
Το deck είναι ένας πίνακας, ο οποίος στο κάθε στοιχείο έχει τα παρακάτω:

| Attribute     | Description   | Values|
| ------------- |-------------| -----|
| card_id       | Το μοναδικό id της κάρτας | 0,1,2,3,etc |
| card_color    | Το χρώμα της κάρτας      |  R,G,Y,B,W |
| card_text     | Το νούμερο/αριθμός της κάρτας | 1,5,6,R,S,W,etc |

## Deck_reset
___
O deck_reset πίνακας κάνει replace τα στοιχεία του στον deck πίνακα:

| Attribute     | Description   | Values|
| ------------- |-------------| -----|
| card_id       | Το μοναδικό id της κάρτας | 0,1,2,3,etc |
| card_color    | Το χρώμα της κάρτας      |  R,G,Y,B,W |
| card_text     | Το νούμερο/αριθμός της κάρτας | 1,5,6,R,S,W,etc |

## Players
___
O κάθε παίκτης έχει τα παρακάτω στοιχεία:

| Attribute     | Description   | Values|
| ------------- |-------------| -----|
| username      | Όνομα παίκτη | String |
| player_name   | Το όνομα της σειράς του παίκτη  |  'p1','p2' |
| token         | To κρυφό token του παίκτη. Επιστρέφεται μόνο τη στιγμή της εισόδου του παίκτη στο παιχνίδι | HEX |

## Game_status
___
H κατάσταση παιχνιδιού έχει τα παρακάτω στοιχεία:

| Attribute     | Description   | Values|
| ------------- |-------------| -----|
| status        | Κατάσταση Παιχνιδιού | 'not active', 'initialized', 'started', 'ended', 'aborded' |
| p_turn        | Το όνομα της σειράς του παίκτη     |  'p1','p2',null |
| result        | Το όνομα της σειράς του παίκτη που κέρδισε | 'p1','p2',null |
| last_change   | Τελευταία αλλαγή/ενέργεια στην κατάσταση του παιχνιδιού | timestamp |

## Hand
___
Οι κάρτες που έχει ο κάθε παίκτης στο χέρι του:

| Attribute     | Description   | Values|
| ------------- |-------------| -----|
| card_id       | Το μοναδικό id της κάρτας | 0,1,2,3,etc |
| player_name   | Το όνομα της σειράς του παίκτη  |  'p1','p2',null |

## Play_card
___
Ο πίνακας play_card έχει την πάνω κάρτα του σωρού:

| Attribute     | Description   | Values|
| ------------- |-------------| -----|
| play_card_id  | Το μοναδικό id της κάρτας σωρού | INT |
| card_id       | Το μοναδικό id της κάρτας  |  0,1,2,3,etc |
| card_text     | Το νούμερο/αριθμός της κάρτας | 1,5,6,R,S,W,etc |

## Remaining_deck
___
O πίνακας με τις κάρτες που δεν έχουν παιχτεί ακόμη:

| Attribute     | Description   | Values|
| ------------- |-------------| -----|
| card_id       | Το μοναδικό id της κάρτας  |  0,1,2,3,etc |
| card_color    | Το χρώμα της κάρτας      |  R,G,Y,B,W |
| card_text     | Το νούμερο/αριθμός της κάρτας | 1,5,6,R,S,W,etc |

## Remaining_deck_reset
___
O remaining_deck_reset πίνακας κάνει replace τα στοιχεία του στον remaining_deck πίνακα:

| Attribute     | Description   | Values|
| ------------- |-------------| -----|
| card_id       | Το μοναδικό id της κάρτας  |  0,1,2,3,etc |
| card_color    | Το χρώμα της κάρτας      |  R,G,Y,B,W |
| card_text     | Το νούμερο/αριθμός της κάρτας | 1,5,6,R,S,W,etc |

___

# Περιγραφή API

## Methods


### Status

#### Ανάγνωση κατάστασης παιχνιδιού

```
GET /status/
```

Επιστρέφει το στοιχείο [Game_status](#Game_status).


### Board

#### Ανάγνωση Board

```
GET /board/
```

Επιστρέφει το [Board](#Board).

### Reset

#### Reset το παιχνίδι

```
POST /reset/
```

Κάνει reset όλους τους πίνακες για νέο παιχνίδι απο την αρχή.

### Player

#### Ανάγνωση στοιχείων παίκτη

```
GET /players/:p
```

Επιστρέφει τα στοιχεία του παίκτη p ή όλων των παικτών αν παραληφθεί. Το p μπορεί να είναι 'p1' ή 'p2'.

#### Καθορισμός στοιχείων παίκτη
```
PUT /players/:p
```
Json Data:

| Field             | Description                 | Required   |
| ----------------- | --------------------------- | ---------- |
| `username`        | Το username για τον παίκτη p. | yes      |
| `player_name`     | Το όνομα της σειράς του παίκτη | yes     |


Κάνει insert τον παίκτη p στον πίνακα [Players](#Players) και επιστρέφει τα στοιχεία του.

### Turn_change

```
PUT /turn_change/:p
```

Json Data:

| Field             | Description                 | Required   |
| ----------------- | --------------------------- | ---------- |
| `status`          | Κατάσταση Παιχνιδιού          | yes      |
| `p_turn`          | Το όνομα της σειράς του παίκτη | yes      |

Αλλάζει την σείρα του παίκτη και επιστρέφει την νέα κατάσταση του παιχνιδιού.

### Draw_p1

```
PUT /draw_p1/
```

Json Data:

| Field             | Description                 | Required   |
| ----------------- | --------------------------- | ---------- |
| `card_id`         | Το μοναδικό id της κάρτας   |  yes       |
| `card_color`      | Το χρώμα της κάρτας         |  yes       |
| `card_text`       | Το νούμερο/αριθμός της κάρτας | yes      |


Επιστρέφει την κάρτα που τράβηξε ο παίκτης p1.

### Draw_p2

```
PUT /draw_p2/
```

Json Data:

| Field             | Description                 | Required   |
| ----------------- | --------------------------- | ---------- |
| `card_id`         | Το μοναδικό id της κάρτας   |  yes       |
| `card_color`      | Το χρώμα της κάρτας         |  yes       |
| `card_text`       | Το νούμερο/αριθμός της κάρτας | yes      |


Επιστρέφει την κάρτα που τράβηξε ο παίκτης p2.


### Do_move

```
PUT /do_move/:color:/:card:/:p/ 
```

Διαγράφει την κάρτα που παίχτηκε απο τον πίνακα `hand` του παίκτη `p` με χρώμα `color` και card_text `card`. Επίσης κάνει update τον πίνακα `play_card` με την κάρτα που παίχτηκε.

___

# Συντελεστές:

### Προγραμματιστής: dpavlidis
### Τεχνολογίες :  HTML, jQuery, MySQL, PHP API.

___










































