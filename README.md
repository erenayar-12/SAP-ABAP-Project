# SAP/ABAP Library Database 
##### In this project, I aimed to create a system to organize the usage of the book and member database. There are 2 main screens that displays Members and Books. However there are several screens as dialog boxes as well. We will see them in the upcoming sections in this README file.

### TABLES
###### We have 3 tables: Member, Book, Owner. Member's attributes are ID (primary key), name, surname, active/passive. Book's attributes are ID(primary key), name, author, genre. Owner's attributes are User ID(primary key), book ID(Primary key), borrow date, return date.

### THE MEMBER SCREEN
###### In this screen, we see the current user's ID, Name, Surname and Active/Passive situation. Only active members are displayed. Also, there is an additional small column in the leftmost part which allows user to select a row (or member).
###### At the top-right of the page there is a dropdown menu named 'Choose an option'. These options are 'Add a member', 'Delete a Member', 'Make Passive', 'Give Book' and 'Return Book'.

### THE BOOK SCREEN
###### Book screen shows us the books in the database that is not borrowed currently. We see the books' names, authors, and genres.
###### In this screen, we have two options as pushbuttons being 'Add a Book' and Delete a Book'.

### OPTIONS IN ALL THE SCREENS
#### Add a Member
###### When the user clicked this option, a dialog screen will be displayed. These screen has I/O boxes, which only allowed for input being 'ID', 'Name', 'Surname' and pushbuttons names 'Exit', 'Add'. When thr user filled all the boxes and press add, a code block will be triggered to check whether this member exists (according to ID). If exists, a pop-up message will be shown saying that user exists and returns back to the dialog box. If not exists, user will be implemented to both table and screen and stays in the dialog box to allow user to add more members.
#### Delete Member
###### When a member is selected, if the user selects 'Delete User' option, this user will be deleted from both table and screen and screen will be refreshed. However, if there is no member selected this option won't do anything.
#### Make Passive
###### Similar to deleting a member, clicked user will be passive. When a user becomes passive, the Active/Passive situation will be changed as abap_true from abap_false and Active/Passive column will be changed as 'X'. Since only active members (passive status = abap_false) is displayed, next time the user opens the screen, that member won't be displayed.
#### Give Book.
###### When the user selects a member and selects 'Give Book' option, new screen will be displayed: The Book Screen. 

