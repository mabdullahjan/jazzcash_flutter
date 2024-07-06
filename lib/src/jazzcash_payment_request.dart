import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jazzcash_payment_data_model_v1.dart';

class JazzCashPaymentRequest {
  String integritySalt;
  String merchantID;
  String merchantPassword;
  String transactionUrl;

  JazzCashPaymentRequest({
    required this.integritySalt,
    required this.merchantID,
    required this.merchantPassword,
    required this.transactionUrl,
  });

  String generateRequest({required JazzCashPaymentDataModelV1 jazzCashPaymentDataModel}) {
    return '''
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>JazzCash Payment Request</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <!-- jQuery Slim -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <!-- Popper.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <!-- Bootstrap JS -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <!-- CryptoJS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/crypto-js.min.js"></script>
    <!-- Moment.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" integrity="sha512-qTXRIMyZIFb8iQcfjXWCO8+M5Tbc38Qi5WzdPOYZHIlZpzBHG3L3by84BBBOiRGiEb7KKtAOAs5qYdUiZiQNNQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script>
      window.onload = function () {
        getDynamicValues();
      };
      function getDynamicValues() {
        let amount = ${jazzCashPaymentDataModel.ppAmount};
        document.getElementsByName("pp_Amount")[0].value = amount * 100;
        let transID = "T" + Math.floor(Math.random() * 1000000000000);
        document.getElementsByName("pp_TxnRefNo")[0].value = transID;
        document.getElementsByName("pp_TxnDateTime")[0].value = moment().format("YYYYMMDDHHmmss");
        document.getElementsByName("pp_TxnExpiryDateTime")[0].value = moment().add(1, "days").format("YYYYMMDDHHmmss");
      }
      function getTxnType() {
        document.getElementsByName("pp_TxnType2")[0].value = document.getElementsByName("pp_TxnType")[0].value;
      }
      function CalculateHash() {
        var pp_Amount = document.getElementsByName("pp_Amount")[0].value;
        var pp_BankID = document.getElementsByName("pp_BankID")[0].value;
        var pp_BillReference = document.getElementsByName("pp_BillReference")[0].value;
        var pp_Description = document.getElementsByName("pp_Description")[0].value;
        var pp_Language = document.getElementsByName("pp_Language")[0].value;
        var pp_MerchantID = document.getElementsByName("pp_MerchantID")[0].value;
        var pp_Password = document.getElementsByName("pp_Password")[0].value;
        var pp_ProductID = document.getElementsByName("pp_ProductID")[0].value;
        var pp_ReturnURL = document.getElementsByName("pp_ReturnURL")[0].value;
        var pp_TxnCurrency = document.getElementsByName("pp_TxnCurrency")[0].value;
        var pp_TxnDateTime = document.getElementsByName("pp_TxnDateTime")[0].value;
        var pp_TxnExpiryDateTime = document.getElementsByName("pp_TxnExpiryDateTime")[0].value;
        var pp_TxnRefNo = document.getElementsByName("pp_TxnRefNo")[0].value;
        var pp_TxnType = document.getElementsByName("pp_TxnType")[0].value;
        var pp_Version = document.getElementsByName("pp_Version")[0].value;
        var ppmpf_1 = document.getElementsByName("ppmpf_1")[0].value;
        var ppmpf_2 = document.getElementsByName("ppmpf_2")[0].value;
        var ppmpf_3 = document.getElementsByName("ppmpf_3")[0].value;
        var ppmpf_4 = document.getElementsByName("ppmpf_4")[0].value;
        var ppmpf_5 = document.getElementsByName("ppmpf_5")[0].value;
        var pp_SubMerchantID = document.getElementsByName("pp_SubMerchantID")[0].value;
        var pp_SecureHash = document.getElementsByName("pp_SecureHash")[0].value;
        var IntegritySalt = document.getElementById("integritySalt").innerText;
        hashString = "";
        hashString += IntegritySalt + "&";
        if (pp_Amount != "") { hashString += pp_Amount + "&"; }
        if (pp_BankID != "") { hashString += pp_BankID + "&"; }
        if (pp_BillReference != "") { hashString += pp_BillReference + "&"; }
        if (pp_Description != "") { hashString += pp_Description + "&"; }
        if (pp_Language != "") { hashString += pp_Language + "&"; }
        if (pp_MerchantID != "") { hashString += pp_MerchantID + "&"; }
        if (pp_Password != "") { hashString += pp_Password + "&"; }
        if (pp_ProductID != "") { hashString += pp_ProductID + "&"; }
        if (pp_ReturnURL != "") { hashString += pp_ReturnURL + "&"; }
        if (pp_SubMerchantID != "") { hashString += pp_SubMerchantID + "&"; }
        if (pp_TxnCurrency != "") { hashString += pp_TxnCurrency + "&"; }
        if (pp_TxnDateTime != "") { hashString += pp_TxnDateTime + "&"; }
        if (pp_TxnExpiryDateTime != "") { hashString += pp_TxnExpiryDateTime + "&"; }
        if (pp_TxnRefNo != "") { hashString += pp_TxnRefNo + "&"; }
        if (pp_TxnType != "") { hashString += pp_TxnType + "&"; }
        if (pp_Version != "") { hashString += pp_Version + "&"; }
        if (ppmpf_1 != "") { hashString += ppmpf_1 + "&"; }
        if (ppmpf_2 != "") { hashString += ppmpf_2 + "&"; }
        if (ppmpf_3 != "") { hashString += ppmpf_3 + "&"; }
        if (ppmpf_4 != "") { hashString += ppmpf_4 + "&"; }
        if (ppmpf_5 != "") { hashString += ppmpf_5 + "&"; }
        hashString = hashString.slice(0, -1);
        document.getElementById("sorted_string").value = hashString;
      }
      setTimeout(function(){ submitForm(); }, 100);
      function submitForm() {
        CalculateHash();
        var IntegritySalt = document.getElementById("integritySalt").innerText;
        var hash = CryptoJS.HmacSHA256(document.getElementById("sorted_string").value, IntegritySalt);
        document.getElementsByName("pp_SecureHash")[0].value = hash + "";
        document.jsform.submit();
      }
    </script>
  </head>
  <body class="bg-light" style="display: none">
    <div class="container mt-5 bg-white">
      <h4>JazzCash HTTP POST Sample (Page Redirection v1.1)</h4>
      <label id="integritySalt" style="display: none">$integritySalt</label>
      <form name="jsform" method="post" action="$transactionUrl">
        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <input type="text" class="form-control" name="pp_Version" placeholder="pp_Version" value="${jazzCashPaymentDataModel.ppVersion}" />
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <input type="text" class="form-control" name="pp_ProductID" placeholder="pp_ProductID" value="${jazzCashPaymentDataModel.ppProductID}" />
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <input type="text" class="form-control" name="pp_TxnRefNo" placeholder="pp_TxnRefNo" />
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <input type="text" class="form-control" name="pp_TxnDateTime" placeholder="pp_TxnDateTime" />
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <input type="text" class="form-control" name="pp_TxnExpiryDateTime" placeholder="pp_TxnExpiryDateTime" />
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-group">
              <input type="text" class="form-control" name="pp_Amount" placeholder="pp_Amount" />
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-md-12">
            <div class="form-group">
              <input type="text" class="form-control" name="pp_TxnCurrency" placeholder="pp_TxnCurrency" value="${jazzCashPaymentDataModel.ppTxnCurrency}" />
            </div>
          </div>
        </div>

        <input type="hidden" name="pp_Password" value="${merchantPassword}" />
        <input type="hidden" name="pp_TxnType" value="${jazzCashPaymentDataModel.ppTxnType}" />
        <input type="hidden" name="pp_Language" value="${jazzCashPaymentDataModel.ppLanguage}" />
        <input type="hidden" name="pp_MerchantID" value="${merchantID}" />
        <input type="hidden" name="pp_BillReference" value="${jazzCashPaymentDataModel.ppBillReference}" />
        <input type="hidden" name="pp_Description" value="${jazzCashPaymentDataModel.ppDescription}" />
        <input type="hidden" name="pp_BankID" value="${jazzCashPaymentDataModel.ppBankID}" />
        <input type="hidden" name="pp_SubMerchantID" value="${jazzCashPaymentDataModel.ppSubMerchantID}" />
        <input type="hidden" name="ppmpf_1" value="${jazzCashPaymentDataModel.ppmpf1}" />
        <input type="hidden" name="ppmpf_2" value="${jazzCashPaymentDataModel.ppmpf2}" />
        <input type="hidden" name="ppmpf_3" value="${jazzCashPaymentDataModel.ppmpf3}" />
        <input type="hidden" name="ppmpf_4" value="${jazzCashPaymentDataModel.ppmpf4}" />
        <input type="hidden" name="ppmpf_5" value="${jazzCashPaymentDataModel.ppmpf5}" />
        <input type="hidden" name="pp_ReturnURL" value="${jazzCashPaymentDataModel.ppReturnURL}" />
        <input type="hidden" name="pp_TxnType2" value="" />
        <input type="hidden" name="pp_SecureHash" value="" id="pp_SecureHash" />
        <input type="hidden" name="pp_Version2" value="" id="pp_Version2" />
        <input type="hidden" name="pp_Version" value="${jazzCashPaymentDataModel.ppVersion}" />

        <input type="hidden" id="sorted_string" name="sorted_string" />

        <div class="form-group">
          <button type="submit" class="btn btn-primary">Submit</button>
        </div>
      </form>
    </div>
  </body>
</html>
    ''';
  }
}
