
import 'dart:convert';

import 'package:week9/donation/donation_model.dart';

const List<Map<String, dynamic>> donationSampleData = [
    {
        "category": "Cash",
        "isForPickup": false,
        "weight": "28.46",
        "imageUrl": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/619.jpg",
        "pickupDropoffTime": "1969-07-20 20:18:04Z",
        "addressesForPickup": "Apt. 712",
        "contactNumber": "+639542890821",
        "qrCode": "BoGp:[ZU0^",
        "status": "Cancelled"
    },
    {
        "category": "Cash",
        "isForPickup": false,
        "weight": "89.73",
        "imageUrl": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/654.jpg",
        "pickupDropoffTime": "1969-07-20 20:18:04Z",
        "addressesForPickup": "Suite 764",
        "contactNumber": "+639911775848",
        "qrCode": "n;](?{3lpG",
        "status": "Completed"
    },
    {
        "category": "Food",
        "isForPickup": true,
        "weight": "14.95",
        "imageUrl": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/602.jpg",
        "pickupDropoffTime": "1969-07-20 20:18:04Z",
        "addressesForPickup": "Suite 651",
        "contactNumber": "+639027217401",
        "qrCode": "lLR\\jOQ7#q",
        "status": "Cancelled"
    },
    {
        "category": "Clothes",
        "isForPickup": false,
        "weight": "7.37",
        "imageUrl": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1123.jpg",
        "pickupDropoffTime": "1969-07-20 20:18:04Z",
        "addressesForPickup": "Apt. 500",
        "contactNumber": "+639371499763",
        "qrCode": "bFmcrS':I|",
        "status": "Cancelled"
    },
    {
        "category": "Necessities",
        "isForPickup": false,
        "weight": "59.31",
        "imageUrl": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1117.jpg",
        "pickupDropoffTime": "1969-07-20 20:18:04Z",
        "addressesForPickup": "Apt. 108",
        "contactNumber": "+639470330664",
        "qrCode": "ZfHtOf6?dp",
        "status": "Cancelled"
    },
    {
        "category": "Others",
        "isForPickup": false,
        "weight": "39.16",
        "imageUrl": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1125.jpg",
        "pickupDropoffTime": "1969-07-20 20:18:04Z",
        "addressesForPickup": "Suite 972",
        "contactNumber": "+639638263823",
        "qrCode": "HHB5WQPts}",
        "status": "Completed"
    },
    {
        "category": "Clothes",
        "isForPickup": false,
        "weight": "64.14",
        "imageUrl": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/880.jpg",
        "pickupDropoffTime": "1969-07-20 20:18:04Z",
        "addressesForPickup": "Suite 459",
        "contactNumber": "+639118911729",
        "qrCode": "z<p2-%o'M5",
        "status": "Cancelled"
    },
    {
        "category": "Cash",
        "isForPickup": false,
        "weight": "24.41",
        "imageUrl": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1239.jpg",
        "pickupDropoffTime": "1969-07-20 20:18:04Z",
        "addressesForPickup": "Apt. 200",
        "contactNumber": "+639585063766",
        "qrCode": "Nw)fu&?bX;",
        "status": "Pending"
    },
    {
        "category": "Necessities",
        "isForPickup": false,
        "weight": "27.31",
        "imageUrl": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/468.jpg",
        "pickupDropoffTime": "1969-07-20 20:18:04Z",
        "addressesForPickup": "Apt. 580",
        "contactNumber": "+639388544281",
        "qrCode": "5'G:w/LmKc",
        "status": "Cancelled"
    },
    {
        "category": "Necessities",
        "isForPickup": false,
        "weight": "68.30",
        "imageUrl": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/83.jpg",
        "pickupDropoffTime": "1969-07-20 20:18:04Z",
        "addressesForPickup": "Apt. 372",
        "contactNumber": "+639900250786",
        "qrCode": "Oh{SHI5m|0",
        "status": "Completed"
    },
    {
        "category": "Food",
        "isForPickup": true,
        "weight": "12.32",
        "imageUrl": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1173.jpg",
        "pickupDropoffTime": "1969-07-20 20:18:04Z",
        "addressesForPickup": "Apt. 511",
        "contactNumber": "+639447558905",
        "qrCode": "Bid=U;35P",
        "status": "Completed"
    },
    {
        "category": "Food",
        "isForPickup": true,
        "weight": "40.89",
        "imageUrl": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/276.jpg",
        "pickupDropoffTime": "1969-07-20 20:18:04Z",
        "addressesForPickup": "Suite 877",
        "contactNumber": "+639007877956",
        "qrCode": ",N-4D:aln\"",
        "status": "Completed"
    },
    {
        "category": "Food",
        "isForPickup": false,
        "weight": "3.51",
        "imageUrl": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/4.jpg",
        "pickupDropoffTime": "1969-07-20 20:18:04Z",
        "addressesForPickup": "Apt. 427",
        "contactNumber": "+639020158427",
        "qrCode": ":V^Xm4Ljv?",
        "status": "Pending"
    },
    {
        "category": "Necessities",
        "isForPickup": false,
        "weight": "52.13",
        "imageUrl": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/504.jpg",
        "pickupDropoffTime": "1969-07-20 20:18:04Z",
        "addressesForPickup": "Suite 703",
        "contactNumber": "+639006629505",
        "qrCode": "hj]zs\"x!M`",
        "status": "Pending"
    },
    {
        "category": "Cash",
        "isForPickup": false,
        "weight": "57.83",
        "imageUrl": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/468.jpg",
        "pickupDropoffTime": "1969-07-20 20:18:04Z",
        "addressesForPickup": "Suite 264",
        "contactNumber": "+639986902762",
        "qrCode": "#.)ZYnRaWk",
        "status": "Pending"
    },
    {
        "category": "Cash",
        "isForPickup": true,
        "weight": "87.18",
        "imageUrl": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/709.jpg",
        "pickupDropoffTime": "1969-07-20 20:18:04Z",
        "addressesForPickup": "Apt. 283",
        "contactNumber": "+639133112075",
        "qrCode": "olqBYA?6{c",
        "status": "Pending"
    },
    {
        "category": "Clothes",
        "isForPickup": true,
        "weight": "33.73",
        "imageUrl": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/368.jpg",
        "pickupDropoffTime": "1969-07-20 20:18:04Z",
        "addressesForPickup": "Suite 716",
        "contactNumber": "+639926218373",
        "qrCode": "A61gIfDaa6",
        "status": "Pending"
    },
];

List<Donation> maptodonation(List<Map<String, dynamic>> jsonArray) {
  List<Donation> sampleData = [];
  jsonArray.forEach((object) {
    sampleData.add(Donation.fromJson(object));
  });
  return sampleData;
}

List<Donation> donationArray = maptodonation(donationSampleData);