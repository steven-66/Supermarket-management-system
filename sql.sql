
create table open_time(
tid char(1),
day nvarchar2(10),
start_time nvarchar2(8), 
close_time nvarchar2(8), 
primary key(tid,day));



create table store(
sid nvarchar2(6), 
street nvarchar2(20), 
state nvarchar2(10), 
city nvarchar2(10), 
zip char(5), 
tid char(5), 
primary key(sid)
);

create table customer(
cid nvarchar2(8), 
name nvarchar2(20) not null,
email nvarchar2(20) not null, 
sid nvarchar2(6), 
phone_num nvarchar2(20),
primary key(cid), 
foreign key(sid) references store);

create table credit_card(
cid nvarchar2(8), 
card_num char(12), 
holder nvarchar2(8),
expiration nvarchar2(8), 
cvv char(3), 
primary key(cid,card_num), 
foreign key(cid) references customer);

create table c_order(cid nvarchar2(8), 
order_num nvarchar2(10), 
order_date date, 
primary key(order_num), 
foreign key(cid) references customer);

create table product(
upc nvarchar2(10), 
p_name nvarchar2(20), 
p_size nvarchar2(8), 
packaging nvarchar2(20), 
vendor nvarchar2(10),
brand nvarchar2(8), 
price numeric(6,2), 
primary key(upc),
check(p_size in('small', 'medium', 'large'))); 

create table category(
type1 nvarchar2(8), 
type2 nvarchar2(8), 
upc nvarchar2(10), 
primary key(type1, upc), 
foreign key(upc) references product);

create table check_out(
order_num nvarchar2(10), 
upc nvarchar2(10), 
quantity int, 
primary key(order_num, upc), 
foreign key(order_num) references c_order, 
foreign key(upc) references product);

create table warehouse(
sid nvarchar2(6),
curr_date date,
quatity int, 
upc nvarchar2(10),
capacity int,
primary key(sid, curr_date, upc),
foreign key(sid) references store, 
foreign key (upc) references product);
alter table warehouse add constraint max_amount check(quatity <= 2000);

create table employee(
eid nvarchar2(5), 
password nvarchar2(10), 
sid nvarchar2(6), 
primary key(eid), 
foreign key(sid) references store);

create view total_amount as(select sum(quatity) as amount,sid,curr_date from warehouse group by sid, curr_date);
create view check_out_amount as(
select sum(price) as price_amount, order_num from  product  natural join check_out group by order_num);
create view product_type as(select * from product natural join category);
create view store_open as (select sid, day, start_time, close_time from store natural join open_time);

	



	







