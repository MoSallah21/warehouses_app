// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Imports`
  String get imports {
    return Intl.message(
      'Imports',
      name: 'imports',
      desc: '',
      args: [],
    );
  }

  /// `Exports`
  String get exports {
    return Intl.message(
      'Exports',
      name: 'exports',
      desc: '',
      args: [],
    );
  }

  /// `Add User`
  String get addUser {
    return Intl.message(
      'Add User',
      name: 'addUser',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get reports {
    return Intl.message(
      'Reports',
      name: 'reports',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Store`
  String get store {
    return Intl.message(
      'Store',
      name: 'store',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Unit`
  String get unit {
    return Intl.message(
      'Unit',
      name: 'unit',
      desc: '',
      args: [],
    );
  }

  /// `Count`
  String get count {
    return Intl.message(
      'Count',
      name: 'count',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get buy {
    return Intl.message(
      'Buy',
      name: 'buy',
      desc: '',
      args: [],
    );
  }

  /// `Sell`
  String get sell {
    return Intl.message(
      'Sell',
      name: 'sell',
      desc: '',
      args: [],
    );
  }

  /// `Choose Invoice Type`
  String get chooseInvoiceType {
    return Intl.message(
      'Choose Invoice Type',
      name: 'chooseInvoiceType',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message(
      'Product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `Add Successfully`
  String get addSuccessfully {
    return Intl.message(
      'Add Successfully',
      name: 'addSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Add Failed`
  String get addFailed {
    return Intl.message(
      'Add Failed',
      name: 'addFailed',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Add Unit`
  String get addUnit {
    return Intl.message(
      'Add Unit',
      name: 'addUnit',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Select One`
  String get selectOne {
    return Intl.message(
      'Select One',
      name: 'selectOne',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Dealer`
  String get dealer {
    return Intl.message(
      'Dealer',
      name: 'dealer',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get customer {
    return Intl.message(
      'Customer',
      name: 'customer',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Delegate`
  String get delegatee {
    return Intl.message(
      'Delegate',
      name: 'delegatee',
      desc: '',
      args: [],
    );
  }

  /// `Add Delegate`
  String get addDelegate {
    return Intl.message(
      'Add Delegate',
      name: 'addDelegate',
      desc: '',
      args: [],
    );
  }

  /// `Add Customer`
  String get addCustomer {
    return Intl.message(
      'Add Customer',
      name: 'addCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Add Dealer`
  String get addDealer {
    return Intl.message(
      'Add Dealer',
      name: 'addDealer',
      desc: '',
      args: [],
    );
  }

  /// `Add Dealer`
  String get addNewDealer {
    return Intl.message(
      'Add Dealer',
      name: 'addNewDealer',
      desc: '',
      args: [],
    );
  }

  /// `Add Customer`
  String get addNewCustomer {
    return Intl.message(
      'Add Customer',
      name: 'addNewCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Add User`
  String get addNewUser {
    return Intl.message(
      'Add User',
      name: 'addNewUser',
      desc: '',
      args: [],
    );
  }

  /// `Add Product`
  String get addNewProduct {
    return Intl.message(
      'Add Product',
      name: 'addNewProduct',
      desc: '',
      args: [],
    );
  }

  /// `Enter new user`
  String get enterNewUser {
    return Intl.message(
      'Enter new user',
      name: 'enterNewUser',
      desc: '',
      args: [],
    );
  }

  /// `Enter new customer`
  String get enterNewCustomer {
    return Intl.message(
      'Enter new customer',
      name: 'enterNewCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Enter new dealer`
  String get enterNewDealer {
    return Intl.message(
      'Enter new dealer',
      name: 'enterNewDealer',
      desc: '',
      args: [],
    );
  }

  /// `Enter new delegate`
  String get enterNewDelegate {
    return Intl.message(
      'Enter new delegate',
      name: 'enterNewDelegate',
      desc: '',
      args: [],
    );
  }

  /// `Enter new unit`
  String get enterNewUnit {
    return Intl.message(
      'Enter new unit',
      name: 'enterNewUnit',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Date`
  String get invoiceDate {
    return Intl.message(
      'Invoice Date',
      name: 'invoiceDate',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get enter {
    return Intl.message(
      'Enter',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `Total Price`
  String get totalPrice {
    return Intl.message(
      'Total Price',
      name: 'totalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Enter new product`
  String get enterNewProduct {
    return Intl.message(
      'Enter new product',
      name: 'enterNewProduct',
      desc: '',
      args: [],
    );
  }

  /// `Product name`
  String get productName {
    return Intl.message(
      'Product name',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `Dealer name`
  String get dealerName {
    return Intl.message(
      'Dealer name',
      name: 'dealerName',
      desc: '',
      args: [],
    );
  }

  /// `Customer name`
  String get customerName {
    return Intl.message(
      'Customer name',
      name: 'customerName',
      desc: '',
      args: [],
    );
  }

  /// `Delegate name`
  String get delegateName {
    return Intl.message(
      'Delegate name',
      name: 'delegateName',
      desc: '',
      args: [],
    );
  }

  /// `Edit Customer`
  String get editCustomer {
    return Intl.message(
      'Edit Customer',
      name: 'editCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Edit Delegate`
  String get editDelegate {
    return Intl.message(
      'Edit Delegate',
      name: 'editDelegate',
      desc: '',
      args: [],
    );
  }

  /// `Edit Dealer`
  String get editDealer {
    return Intl.message(
      'Edit Dealer',
      name: 'editDealer',
      desc: '',
      args: [],
    );
  }

  /// `Edit Product`
  String get editProduct {
    return Intl.message(
      'Edit Product',
      name: 'editProduct',
      desc: '',
      args: [],
    );
  }

  /// `Customers`
  String get allCustomers {
    return Intl.message(
      'Customers',
      name: 'allCustomers',
      desc: '',
      args: [],
    );
  }

  /// `Dealers`
  String get allDealers {
    return Intl.message(
      'Dealers',
      name: 'allDealers',
      desc: '',
      args: [],
    );
  }

  /// `Delegates`
  String get allDelegates {
    return Intl.message(
      'Delegates',
      name: 'allDelegates',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get allProducts {
    return Intl.message(
      'Products',
      name: 'allProducts',
      desc: '',
      args: [],
    );
  }

  /// `Units`
  String get allUnits {
    return Intl.message(
      'Units',
      name: 'allUnits',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Number`
  String get invoiceNumber {
    return Intl.message(
      'Invoice Number',
      name: 'invoiceNumber',
      desc: '',
      args: [],
    );
  }

  /// `Administrator name`
  String get administratorName {
    return Intl.message(
      'Administrator name',
      name: 'administratorName',
      desc: '',
      args: [],
    );
  }

  /// `Administrator phone`
  String get administratorPhone {
    return Intl.message(
      'Administrator phone',
      name: 'administratorPhone',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete`
  String get deleteAlert {
    return Intl.message(
      'Are you sure to delete',
      name: 'deleteAlert',
      desc: '',
      args: [],
    );
  }

  /// `Confirm delete`
  String get confirmDelete {
    return Intl.message(
      'Confirm delete',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Delete Successfully`
  String get deleteSuccessfully {
    return Intl.message(
      'Delete Successfully',
      name: 'deleteSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Delete Failed`
  String get deleteFailed {
    return Intl.message(
      'Delete Failed',
      name: 'deleteFailed',
      desc: '',
      args: [],
    );
  }

  /// `Edit Failed`
  String get editFailed {
    return Intl.message(
      'Edit Failed',
      name: 'editFailed',
      desc: '',
      args: [],
    );
  }

  /// `Edit Successfully`
  String get editSuccessfully {
    return Intl.message(
      'Edit Successfully',
      name: 'editSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `All Invoices`
  String get allInvoices {
    return Intl.message(
      'All Invoices',
      name: 'allInvoices',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
