# Introduction

# SQL Queries

###### Table Setup (DDL)

###### Question 1: The club is adding a new facility - a spa. We need to add it into the facilities table. Use the following values: facid: 9, Name: 'Spa', membercost: 20, guestcost: 30, initialoutlay: 100000, monthlymaintenance: 800. 

```sql
insert into cd.facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
values (9, 'Spa', 20, 30, 100000, 800);
```

###### Questions 2: Let's try adding the spa to the facilities table again. This time, though, we want to automatically generate the value for the next facid, rather than specifying it as a constant. Use the following values for everything else: Name: 'Spa', membercost: 20, guestcost: 30, initialoutlay: 100000, monthlymaintenance: 800.

```sql
insert into cd.facilities(facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) 
values (
(select (select max(facid) from cd.facilities)+1)
, 'Spa', 20, 30, 100000, 800);

```

###### Questions 3: We made a mistake when entering the data for the second tennis court. The initial outlay was 10000 rather than 8000: you need to alter the data to fix the error.

```sql
update cd.facilities set initialoutlay = 10000 where facid = 1;
```

###### Questions 4: We want to alter the price of the second tennis court so that it costs 10% more than the first one. Try to do this without using constant values for the prices, so that we can reuse the statement if we want to.

```sql
update cd.facilities as facs
    set
        membercost = (select membercost * 1.1 from cd.facilities where facid = 0),
        guestcost = (select guestcost * 1.1 from cd.facilities where facid = 0)
    where facs.facid = 1;     
```

###### Questions 5: As part of a clearout of our database, we want to delete all bookings from the cd.bookings table. How can we accomplish this?

```sql
delete from cd.bookings;
truncate cd.bookings;

```

###### Questions 6: We want to remove member 37, who has never made a booking, from our database. How can we achieve that?

```sql
delete from cd.members where memid = 37;
```

###### Questions 7: How can you produce a list of facilities that charge a fee to members, and that fee is less than 1/50th of the monthly maintenance cost? Return the facid, facility name, member cost, and monthly maintenance of the facilities in question.

```sql
select facid, name, membercost, monthlymaintenance 
from cd.facilities 
where membercost > 0 and 
(membercost < monthlymaintenance/50.0);
```

###### Questions 8:  How can you produce a list of all facilities with the word 'Tennis' in their name?

```sql
select * 
from cd.facilities 
where name like '%Tennis%';
```

###### Questions 9: How can you retrieve the details of facilities with ID 1 and 5? Try to do it without using the OR operator.

```sql
select * 
from cd.facilities
where facid = 1 or (facid = 5);
select * from cd.facilities where facid in (1,5);

```

###### Questions 10: How can you produce a list of members who joined after the start of September 2012? Return the memid, surname, firstname, and joindate of the members in question

```sql
select memid, surname, firstname, joindate 
from cd.members 
where joindate >= '2012-09-01';
```

###### Questions 11: You, for some reason, want a combined list of all surnames and all facility names. Yes, this is a contrived example :-). Produce that list!

```sql
select surname from cd.members 
union 
select name from cd.facilities;
```

###### Questions 12: How can you produce a list of the start times for bookings by members named 'David Farrell'?

```sql
select bks.starttime 
from cd.bookings bks 
inner join cd.members mems on mems.memid = bks.memid 
where mems.firstname='David' and mems.surname='Farrell';
```

###### Questions 13: How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'? Return a list of start time and facility name pairings, ordered by the time.

```sql
select bks.starttime as start, facs.name as name 
from cd.facilities as facs inner join cd.bookings as bks 
on facs.facid = bks.facid 
where facs.name in ('Tennis Court 2','Tennis Court 1') and 
bks.starttime >= '2012-09-21' and 
bks.starttime < '2012-09-22' 
order by bks.starttime;
```

###### Questions 14: How can you output a list of all members, including the individual who recommended them (if any)? Ensure that results are ordered by (surname, firstname).

```sql
select mems.firstname as memfname, mems.surname as memsname, recs.firstname as recfname, recs.surname as recsname 
from cd.members as mems left outer join cd.members as recs 
on recs.memid = mems.recommendedby 
order by memsname, memfname;
```

###### Questions 15: How can you output a list of all members who have recommended another member? Ensure that there are no duplicates in the list, and that results are ordered by (surname, firstname).

```sql
select distinct recs.firstname as firstname, recs.surname as surname 
from cd.members mems 
inner join cd.members recs 
on recs.memid = mems.recommendedby order by surname, firstname;
```

###### Questions 16: How can you output a list of all members, including the individual who recommended them (if any), without using any joins? Ensure that there are no duplicates in the list, and that each firstname + surname pairing is formatted as a column and ordered.

```sql
select distinct mems.firstname || ' ' || mems.surname as member,
(select recs.firstname || ' ' || recs.surname as recommender
from cd.members recs
where recs.memid = mems.recommendedby )
from cd.members mems
order by member;
```

###### Questions 17: Produce a count of the number of recommendations each member has made. Order by member ID.

```sql
select recommendedby, count(*) 
from cd.members
where recommendedby is not null
group by recommendedby
order by recommendedby;
```

###### Questions 18: Produce a list of the total number of slots booked per facility. For now, just produce an output table consisting of facility id and slots, sorted by facility id.


```sql
select facid, sum(slots) as "Total Slots" 
from cd.bookings 
group by facid 
order by facid;

```

###### Questions 19: Produce a list of the total number of slots booked per facility in the month of September 2012. Produce an output table consisting of facility id and slots, sorted by the number of slots.

```sql
select facid, sum(slots) as "Total Slots" 
from cd.bookings 
where starttime >= '2012-09-01' and starttime < '2012-10-01' 
group by facid 
order by sum(slots);
```

###### Questions 20: Produce a list of the total number of slots booked per facility per month in the year of 2012. Produce an output table consisting of facility id and slots, sorted by the id and month.

```sql
select facid, extract(month from starttime) as month, sum(slots) as "Total Slots" 
from cd.bookings 
where extract(year from starttime) = 2012 
group by facid, month 
order by facid, month;
```

###### Questions 21: Find the total number of members (including guests) who have made at least one booking.

```sql
select count(distinct memid) from cd.bookings
select count(*) from
	(select distinct memid from cd.bookings) as mems;
```

###### Questions 22: Produce a list of each member name, id, and their first booking after September 1st 2012. Order by member ID.

```sql
select mems.surname, mems.firstname, mems.memid, min(bks.starttime) as starttime 
from cd.bookings bks inner join cd.members mems 
on mems.memid = bks.memid 
where starttime >= '2012-09-01' 
group by mems.surname, mems.firstname, mems.memid 
order by mems.memid;
```

###### Questions 23: Produce a list of member names, with each row containing the total member count. Order by join date, and include guest members.

```sql
select (select count(*) from cd.members) as count, firstname, surname 
from cd.members 
order by joindate;
```


###### Questions 24: Produce a monotonically increasing numbered list of members (including guests), ordered by their date of joining. Remember that member IDs are not guaranteed to be sequential.

```sql
select row_number() over(order by joindate), firstname, surname 
from cd.members 
order by joindate;
```


###### Questions 25: Output the facility id that has the highest number of slots booked. Ensure that in the event of a tie, all tieing results get output.

```sql
select facid, sum(slots) as totalslots 
from cd.bookings 
group by facid 
having sum(slots) = (select max(sum2.totalslots) from (select sum(slots) as totalslots from cd.bookings group by facid ) as sum2);
```


###### Questions 26: Output the names of all members, formatted as 'Surname, Firstname'

```sql
select surname || ', ' || firstname as name from cd.members;
```


###### Questions 27: You've noticed that the club's member table has telephone numbers with very inconsistent formatting. You'd like to find all the telephone numbers that contain parentheses, returning the member ID and telephone number sorted by member ID.

```sql
select memid, telephone from cd.members where telephone similar to '%[()]%';
```


###### Questions 28: You'd like to produce a count of how many members you have whose surname starts with each letter of the alphabet. Sort by the letter, and don't worry about printing out a letter if the count is 0.

```sql
select substr (mems.surname,1,1) as letter, count(*) as count 
from cd.members mems 
group by letter order by letter;
```

EOF
