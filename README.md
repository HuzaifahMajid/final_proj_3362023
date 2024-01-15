## Project Summary

### Travel Reservation System

**Introduction:**
This project involves designing and implementing a relational database system to support the operations of an online travel reservation system. Utilizing HTML for the user interface, MySQL for the database server, and Java with JDBC for connectivity, the system aims to provide a seamless experience for customers, customer representatives, and administrators.

### Proposal Overview

**Project Scope:**
The online travel reservation system allows customers to browse and search for flights, make reservations, and manage their travel history. The system supports one-way, round-trip, and flexible date searches, and customers can interact with the platform to book, cancel, or join a waiting list for flights.

**Key Features:**
- User-friendly interface for customers with limited computer knowledge.
- Differentiated access control for customers, customer representatives, and administrators.
- Comprehensive functionality, including search, sorting, filtering, reservation management, and customer support features.
- Administrative capabilities for managing users, obtaining reports, and overseeing reservations.

**Technologies Used:**
- **Frontend:** HTML, JSP, CSS
- **Backend:** Java, JDBC
- **Database:** MySQL
- **Web Server:** Tomcat
- **Server Hosting:** Local (Apache for static content, Tomcat for Java-based applications)

**Database Design:**
The relational database is structured to accommodate entities such as Customer, Customer Representative, Admin, Flight, Airport, Aircraft, Reservation, and Ticket. Relationships and attributes have been defined to ensure data integrity and meet functional requirements.

**User Interface:**
HTML and its features, including pop-up and pull-down menus, value lists, input/output forms, and customized reports, have been utilized to create a user interface catering to users with limited computer knowledge.

### Readme Instructions

**Setting Up the Project Locally:**
1. Install a local web server (Apache) and MySQL server.
2. Deploy the project on a Tomcat server.
3. Create and configure the MySQL database using the provided SQL scripts.
4. Customize configuration files as needed (e.g., database connection settings).

**Access Control:**
- Admins have full control.
- Customer Representatives can manage reservations and flights.
- Customers can browse, search, and make reservations.

**Running the Application:**
1. Access the homepage through a web browser.
2. Use the search functionality to find and book flights.
3. Administrators and Customer Representatives have additional functionalities within their dashboards.

**Important Notes:**
- Carefully follow provided documentation for database setup and configuration.
- Backup your database before making structural changes.
- For detailed functionalities, refer to the full project proposal document.

This summary serves as a guide to setting up and understanding the key aspects of the travel reservation system project. For detailed instructions and comprehensive information, refer to the complete proposal document.
