import 'jazzcash_payment_data_model_v1.dart';

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

  String generateRequest({
    required JazzCashPaymentDataModelV1 jazzCashPaymentDataModel,
  }) {
    String htmlcustom = '''<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>PR v1.1</title>
    <!-- css -->
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
      integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
      crossorigin="anonymous"
    />
    <!-- scripts -->
    <script
      src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
      integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
      integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
      integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
      crossorigin="anonymous"
    ></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/crypto-js.min.js"></script>

    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"
      integrity="sha512-qTXRIMyZIFb8iQcfjXWCO8+M5Tbc38Qi5WzdPOYZHIlZpzBHG3L3by84BBBOiRGiEb7KKtAOAs5qYdUiZiQNNQ=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    ></script>

    <script>
      window.onload = function () {
        getDynamicValues();
      };
      function getDynamicValues() {
        let amount = ${jazzCashPaymentDataModel.ppAmount};
        document.getElementsByName("pp_Amount")[0].value = amount * 100;

        let transID = "T" + Math.floor(Math.random() * 1000000000000);
        document.getElementsByName("pp_TxnRefNo")[0].value = transID;

        document.getElementsByName("pp_TxnDateTime")[0].value =
          moment().format("YYYYMMDDHHmmss");
        document.getElementsByName("pp_TxnExpiryDateTime")[0].value = moment()
          .add(1, "days")
          .format("YYYYMMDDHHmmss");
      }
      function getTxnType() {
        document.getElementsByName("pp_TxnType2")[0].value =
          document.getElementsByName("pp_TxnType")[0].value;
      }
    </script>
  </head>
  <body class="bg-light">
    <div class="container mt-5 bg-white">
      <h4>JazzCash HTTP POST Sample (Page Redirection v1.1)</h4>
      <label id="integritySalt" style="display: none">$integritySalt</label>

      <form
        name="jsform"
        method="post"
        action="$transactionUrl">
        <!-- Form fields here -->
      </form>

      <textarea
        class="w-50 mt-3"
        id="sorted_string"
        name="sorted_string"
        cols="30"
        rows="5"
      ></textarea>
    </div>

    <script>
      function CalculateHash() {
        // Calculate hash function here
      }

      function submitForm() {
        CalculateHash();
        var IntegritySalt = document.getElementById("integritySalt").innerText;
        var hash = CryptoJS.HmacSHA256(
          document.getElementById("sorted_string").value,
          IntegritySalt
        );

        document.getElementsByName("pp_SecureHash")[0].value = hash + "";
        document.jsform.submit();
      }

      // Submit form automatically on load
      setTimeout(function() {
        submitForm();
      }, 100);
    </script>
  </body>
</html>
''';
    return htmlcustom;
  }
}
