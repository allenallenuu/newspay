'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/assets/AssetManifest.json": "148207447a2c21c7d994da52fe99b237",
"/assets/assets/banner_one@2x.png": "cb5db66342e0a51ab58404e3ff6fe4a9",
"/assets/assets/fonts/OpenSansCondensed-Light.ttf": "4eae10c6071c62c0831f02a680b49a20",
"/assets/assets/home_card@2x.png": "98fa4491c933d9bf787fd668ee7cccf1",
"/assets/assets/home_daili@2x.png": "4b8f40b581200977d93ed325e448bb32",
"/assets/assets/home_manual@2x.png": "525fc62e63925eaa1e376b4cac31f195",
"/assets/assets/home_minefields@2x.png": "90b5c3a8b1a65e78a29e3d259773c657",
"/assets/assets/home_money@2x.png": "056d9866e4ed9ebbe97cc5e8afc83354",
"/assets/assets/home_notice@2x.png": "261a7035e1e3961100ecb6bcea21775d",
"/assets/assets/home_operation@2x.png": "4291df4fdbaf57adc76a98bfff34c0ac",
"/assets/assets/ic_home_select@2x.png": "6f005e745466eb44f0707beebbee03fd",
"/assets/assets/ic_home_unselect@2x.png": "297026f1ad5ea9ce9851d29e24f1e754",
"/assets/assets/ic_mine_select@2x.png": "08c489f5fc8ff43a58900ed12f0a7b02",
"/assets/assets/ic_mine_unselect@2x.png": "441aeb90a306d4672b1da5e935117853",
"/assets/assets/ic_single_select@2x.png": "582649857f5c793736ea4972655f34d9",
"/assets/assets/ic_single_unselect@2x.png": "4a839747b379001f9cad7f5d471d1f93",
"/assets/assets/icon_channel@2x.png": "12e8acdad299648ead54c54fd08e31b2",
"/assets/assets/icon_course@2x.png": "94b6ee1d2abbfab5d2ab137acae24d68",
"/assets/assets/icon_course_detail@2x.png": "502b1bfc737e72b5b29d53e337499b71",
"/assets/assets/icon_defalut@2x.png": "08a3b59960d94ba21c21643f0ddf74b5",
"/assets/assets/icon_flow@2x.png": "621d43ab81861ec9d58eb082876cd0da",
"/assets/assets/icon_flow_detail@2x.png": "6b689a5ca74577de62dc5cf7198a17f5",
"/assets/assets/icon_mannual_flow@2x.png": "f8473092278ce17d0ffed44342a7dd3f",
"/assets/assets/icon_manual_channel@2x.png": "ba6617b7fc53f377a0cd1df73a230827",
"/assets/assets/icon_manual_flow@2x.png": "35d047d3bfffc46c9d6b45996182fb65",
"/assets/assets/icon_manual_recharge@2x.png": "29458b46daf9609cb39ff56d8afe3821",
"/assets/assets/icon_monad@2x.png": "cbb1138f9d9de2b64afa542449b78182",
"/assets/assets/icon_operation@2x.png": "24eaff04c6c364ed5ef7c5db92e7f58a",
"/assets/assets/icon_recharge@2x.png": "1a4ae8c6c7c672b8aca71012a4691866",
"/assets/assets/icon_yinhangka@2x.png": "930d543680048b65686ba8ff06b46423",
"/assets/assets/login_account_select@2x.png": "9c6502c7ff03a80e1f2b7b684a2aa759",
"/assets/assets/login_account_unselect@2x.png": "4076c66754b0bf613d8d347f28ce0b06",
"/assets/assets/login_code_select@2x.png": "0b74098f38801d63c7313ffe9a3d7cd0",
"/assets/assets/login_code_unselect@2x.png": "c13d501e1da3f3f82720c95e35f2906e",
"/assets/assets/login_inviteCode_select@2x.png": "61382753f1a0cbd813e86b523d699f61",
"/assets/assets/login_inviteCode_unselect@2x.png": "d8845792fc2a78ae7efc23ac69bbeeda",
"/assets/assets/login_password_select@2x.png": "cf7b38e0cb1ed8b0826a1da9aba1e7da",
"/assets/assets/login_password_unselect@2x.png": "778f70f4237118c281724136ad8ea42c",
"/assets/assets/login_phone_select@2x.png": "5a3eeaf87deb2b1bdd0ca1de07262446",
"/assets/assets/login_phone_unselect@2x.png": "b44a48a6838872657638c37a5af92818",
"/assets/assets/logo@2x.png": "0ca05342c77d810f916a0f4ad258c8e2",
"/assets/assets/my_page_app@2x.png": "a05b9715774991ca94b94019201510ad",
"/assets/assets/my_page_avatar@2x.png": "aa3a9885fda8576e4259f5ac0e9bec86",
"/assets/assets/my_page_qiangdan@2x.png": "e12c97634c111b15410046d4df46b670",
"/assets/assets/my_page_recharge@2x.png": "51253ab0b3ecdf286bc0d7d07c19e6e0",
"/assets/assets/my_page_record@2x.png": "3dcbc0674c40cb2ebf0779ee62320380",
"/assets/assets/my_page_server_about@2x.png": "5d97223b164907a901b87e30516d9f48",
"/assets/assets/my_page_server_agent@2x.png": "9209b53e092990f878bcd72fc71050d4",
"/assets/assets/my_page_server_customer@2x.png": "94aadbecb0c35bcf919634bac49b79a6",
"/assets/assets/my_page_server_download@2x.png": "a4aaf8e2b7407cfe2b6a258575a19326",
"/assets/assets/my_page_server_help@2x.png": "7adcfe7b3a9a54ea908cce6108c681f0",
"/assets/assets/my_page_server_income@2x.png": "5f8ed3e6bebdb4136d915d43b29b7c9b",
"/assets/assets/my_page_server_safe@2x.png": "c64fc1dde0ea6c7f45ae61f034da4c37",
"/assets/assets/my_page_server_share@2x.png": "e2394382df2a9782f63b3d4f52c6d97d",
"/assets/assets/my_page_server_wait@2x.png": "04edece3b9f7b48b0841daf1c2da200f",
"/assets/assets/my_page_set@2x.png": "7ab949687edce50519b0c3def4068f66",
"/assets/assets/my_page_withdrawal@2x.png": "d664a8d57ce23d15b98f9b3a77e42ded",
"/assets/assets/order_bank_card@2x.png": "dd458e8fbc537bb538a43e0c2d549839",
"/assets/assets/order_error@2x.png": "c33262424633dfe88348e27f34e3d465",
"/assets/assets/order_qiang@2x.png": "c19b47acfc598b232d2ef6001e58bbf7",
"/assets/assets/order_switch_close@2x.png": "c80922d3550e51a075ba30b917365bf6",
"/assets/assets/order_switch_open@2x.png": "fed5bb2a2ddf29c6f535e41dd5ad64f6",
"/assets/assets/order_top_bg@2x.png": "7fb39f89f051a1ce01ed4c91af75a177",
"/assets/assets/share_copy_bg@2x.png": "367f06b75fffbd8f5c9fc003d3824168",
"/assets/assets/share_receive_bg@2x.png": "094fc08063055c5598d7507adbdee18d",
"/assets/assets/share_set_rate_bg@2x.png": "ae7fdffd749456c19f29e7957162b377",
"/assets/assets/splash_bg_icon_black@2x.png": "dcaeaf4c69f620f89f578d09f4027646",
"/assets/FontManifest.json": "2024442c1ec034decdb4d49b22ac9da3",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/assets/LICENSE": "e89072c65f7e38ff5fa1ac399b0dd019",
"/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"/index.html": "b6419ef4f6ae2538b981b456c1f446e9",
"/main.dart.js": "72bbda62e0b302981485bce101b55b88"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
