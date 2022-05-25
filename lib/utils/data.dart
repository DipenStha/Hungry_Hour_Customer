import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const List featured = [
  {"image": "assets/meat.jpg", "Name": "Meat", "Price": "Rs. 445"},
  {
    "image":
        "https://images.unsplash.com/photo-1543339308-43e59d6b73a6?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "\$12.50",
    "is_favorited": false,
    "name": "Greeny Salad",
    "description": "Breakfast and Brunch - American - Sandwich",
    "sources": "Egg - Salad",
    "delivery_fee": "\$1.49 Delivery Fee",
    "rate": "4.8",
    "rate_number": "273"
  },
  {
    "image":
        "https://images.unsplash.com/photo-1511909525232-61113c912358?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "is_favorited": false,
    "name": "Greeny Salad",
    "price": "\$15.25",
    "description": "Breakfast and Brunch - American - Sandwich",
    "sources": "Egg - Salad",
    "delivery_fee": "\$1.49 Delivery Fee",
    "rate": "4.3",
    "rate_number": "273"
  },
  {
    "image":
        "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "price": "\$5.50",
    "name": "Greeny Salad",
    "description": "Breakfast and Brunch - American - Sandwich",
    "sources": "Egg - Salad",
    "is_favorited": true,
    "delivery_fee": "\$1.49 Delivery Fee",
    "rate": "4.5",
    "rate_number": "273"
  },
];

List populars = [
  {
    "image": "assets/meat.jpg",
    "is_favorited": true,
    "price": "\$20.50",
    "name": "Cheesy Stake",
    "description": "Breakfast and Brunch - American - Sandwich",
    "sources": "Egg - Salad",
    "delivery_fee": "\$1.49 Delivery Fee",
    "rate": "4.3",
    "rate_number": "273"
  },
  {
    "image": "assets/momo.jpg",
    "is_favorited": false,
    "name": "Greeny Salad",
    "price": "\$8.50",
    "description": "Breakfast aand Brunch - Juice and Smoothies",
    "time": "15-25 Min",
    "delivery_fee": "\$2.49 Delivery Fee",
    "rate": "4.5",
    "rate_number": "22"
  },
  {
    "image": "assets/chowmein.jpg",
    "is_favorited": false,
    "price": "\$8.50",
    "name": "Milk Breakfast",
    "description": "Breakfast and Brunch - American - Sandwich",
    "sources": "Egg - Salad",
    "delivery_fee": "\$1.49 Delivery Fee",
    "rate": "4.3",
    "rate_number": "273"
  },
  {
    "image": "assets/burger.jpg",
    "is_favorited": false,
    "price": "\$6.90",
    "name": "Freshy Salmon",
    "description": "Breakfast and Brunch - Juice and Smoothies",
    "time": "15-25 Min",
    "delivery_fee": "\$2.49 Delivery Fee",
    "rate": "4.4",
    "rate_number": "22"
  },
];

List categories = [
  {"name": "Salad", "icon": FontAwesomeIcons.cloudMeatball},
  {"name": "Burger", "icon": FontAwesomeIcons.hamburger},
  {"name": "Drink", "icon": FontAwesomeIcons.wineGlass},
  {"name": "Soup", "icon": Icons.rice_bowl},
  {"name": "Snack", "icon": FontAwesomeIcons.cookie},
];
