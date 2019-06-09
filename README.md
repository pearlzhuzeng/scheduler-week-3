# Scheduler

A program to help schedule appointments for service providers.

Project description: https://gist.github.com/jasonswett/68e557c59d3a3473d3bbf669ea8fdd66

The starter code was from [a different group's week 1 code](https://github.com/pearlzhuzeng/scheduler-week-2/commit/305fefaadc133ab87e6441145368316a5c3fba75).

## Current Functionality

### Landing page

Serves as the pointer for different functionalities

### Add a provider

A provider can be added given a name and a phone number

### Remove a provider

After the user selects the remove a provider function, they’ll be shown the full list of providers.
They'll be prompted to type in the name of the provider of whom they wish to remove.
After they type in the name, the program will ask them to confirm the removal of this provider.
If confirmed, the provider will be removed from the list of providers.

### Display all providers

Displays the full list of providers, with their names, phone numbers, services provided, availabilities, and appointments.

### Display all services

Displays the overall list of services.

### Add a service

A service can be added to a provider by giving the name of the service, its price, its length, and the provider to add to.
The service will also be added to the overall list of services.

### Remove a service

A service can be removed from a provider by giving the name of the service and the name of the provider from which to remove.
The service will also be deleted from the overall list of services if no other providers are providing it.

### Add an availability to a provider's list of availabilities

An availability block can be added to a provider's list of availabilities by giving the provider's name, and the availability block's month, date, year, start time, and end time.

### Schedule an appointment

The user will be prompted to type in their name, the provider they'd like the service from, the name of the service, the month, date, year, and start time they would like their appointment to be at.
If no conflicts, the appointment will be scheduled.

### View the schedule of a particular provider

The user will be prompted to type in a provider's name. And the program will print out a list of appointments that has been scheduled with this provider.
