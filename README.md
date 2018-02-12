# Car-Rental-Application
The Car Rental Application is built using Ruby version: 2.3.3 and Rails 5.1.4

Note:
While reviewing the application, if you find the password is wrong, it maybe because some other reviewer had changed it while testing. If you can not find any working account (Superadmin/admin), please email ashekha@ncsu.edu or hhimani@ncsu.edu to let us know, we will reset the credentials. Thank you!

There are 6 preconfigured users for this application.
SuperAdmin:
Email - 'sadmin1@test.com'
Password - 'password'

Email - 'sadmin2@test.com'
Password - 'password'

Admin:
Email - 'admin1@test.com'
Password - 'password'

Email - 'admin2@test.com'
Password - 'password'

Normal User:
Email - 'user1@test.com'
Password - 'password'

Email - 'user2@test.com'
Password - 'password'

Application flow 
1. User can "Login" or "Signup" using the links provided in the navigation bar.
2. After Login, user can access his profile from the "My Profile" link.
3. User can make a reservation by visiting the "New Reservation" link. It displays the list of cars in the system.
4. User can also search for a car, using the "Advanced Search" link under "New Reservation" nav menu.
5. User can "Reserve" or "Checkout" a car from the Car Listing, after clicking on "New Reservation".
6. User can see his previous reservations under the "My Reservations" navigation link.
7. User can "Return" a car from the "My Reservation" navigation link.
8. Reservation history displays all previous reservations made by the user. The reservation cost is the duration multiplied by hourly rate, even if user cancels the reservation before after or during the resevation interval, the amount remains the same.
9. User can "Cancel" his reservation by accessing the information from "My Reservations" navigation link.
10. User can "Suggest a Car" by filling out the car details under "New Reservation" -> "New car Suggestion". The car will not be visible to user until it is approved by the admin.

11. When "SuperAdmin" or "Admin" logs in, they can CRUD users, cars, reservations, searches from the "Manage Resources" navigation link.
12. Admin/Superadmin can navigate from "Manage Resources" page back to home by "Home" link on the top right corner. 
13. Admin/SuperAdmin can add the "Suggested car" from "New Reservation" Car listing page, by clicking on the link "Add Suggested Car".
After the car is approved, it will be visible to all the users.


Special Cases:
1. When a car that is not yet returned is deleted, the reservation status remains "Reserved" until the "End time" of the reservation.
2. When a car that is not yet returned is deleted, the checkout history of the user will say "Reserved" and the deleted car will not be available for any more reservations.
3. When admins delete a car which has been checked out but not returned yet, the status of the reservation will remain "CheckedOut" until the "End time" of the reservation.

