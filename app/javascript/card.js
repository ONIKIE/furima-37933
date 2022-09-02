
const pay = () => {
  Payjp.setPublicKey("pk_test_0c46500ff734898af080e0bb");
  // charge_formの要素を取得し、変数に定義
  const form = document.getElementById("charge-form");
  // クリックで実行
  form.addEventListener("submit", (e) => {
  // 通常のRuby on Railsにおけるフォーム送信処理はキャンセルされる
    e.preventDefault();

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

   // formDataより取得したクレジットカード情報をcardに代入
    const card = {
      number: formData.get("purchase_address[number]"),
      cvc: formData.get("purchase_address[cvc]"),
      exp_month: formData.get("purchase_address[exp_month]"),
      exp_year: `20${formData.get("purchase_address[exp_year]")}`,
    };

    Payjp.createToken(card, (status, response) => {
      console.log()
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      // フォームに残っているクレジットカード情報削除
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");

      // フォームの情報をサーバーサイドに送信
      document.getElementById("charge-form").submit();
      document.getElementById("charge-form").reset();
    });
  });
};
window.addEventListener("load", pay);
