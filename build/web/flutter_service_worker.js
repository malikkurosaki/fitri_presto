'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "b5f28a74e7424858429bb2356d91ff55",
"/": "b5f28a74e7424858429bb2356d91ff55",
"main.dart.js": "a1c3b73fd33b0e9ac176ce7da8a0ff83",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "a19dae1722d861ba54c1c1c4a73bb041",
".git/config": "2629094440aadac3b8d766818e304bc5",
".git/objects/0d/8513b035050f871bbdd959a847bf693b4cb970": "e903ae191c4a61d8bfcff71e2a8c9f86",
".git/objects/95/2031095b314b918f69c99072c98933adca6a66": "f73884683198031bc9a854b12d0fd739",
".git/objects/0c/395f740c9447c5ab39ffd577a98566ed8777d7": "02de602ba77384fa3b994ad841cdd0a1",
".git/objects/68/66d9608ffe7869a0250e607b052f66bddc2b3a": "70ac4f2ca67f1e08352fdf061f5d4260",
".git/objects/57/7e4d37cbb023f05a8069dd3b108588b03df12d": "0dbd5265b649c362c1288ae3ce5646d2",
".git/objects/3b/ad507f7d99b804df5aee5f16659a4aa8980e6d": "7fefcdad225997689c84160204dfda87",
".git/objects/6f/be524b03d35fa097c7c356473c9d73b455186c": "9115f46074f711e76db328f83e581efb",
".git/objects/6f/dc917fd40ebf3be412a778b9093e6a4106b75f": "6578a91488313e107cce32c3750ca7e6",
".git/objects/6f/d078bf1fd60414e5f8243e87a031ffc8a0e73a": "5d9d09df6cc17ebeae777caa3b41c022",
".git/objects/03/29413c5d17c08ac1e4f398a2a546eddb72b41e": "4a91c903991b8db82e73c1f225b3c26f",
".git/objects/03/f161bbe9bf48deadf3172d7eae605345e09049": "e49268fc3e4914d051a0429e19d41829",
".git/objects/03/cd0bc9dd47cf742b810257c5ae0a432e555364": "80fb33e72c5bf967728e8580f5727fcc",
".git/objects/03/af4838adb8d0e77110c38cc196d32919b31ba8": "04f9232b248beaa9b694385a48315332",
".git/objects/03/eaddffb9c0e55fb7b5f9b378d9134d8d75dd37": "87850ce0a3dd72f458581004b58ac0d6",
".git/objects/9b/368eb9c7afabcda2d0635fd261f32cb9c5ee3e": "61142037b7b646032c63402f3e095cc0",
".git/objects/9b/71dc6ca2279d180510e12683cfd32db9922642": "82dc37642cf32ed9d0a388627293e69b",
".git/objects/9e/8c4db674af6dff8ff20d922a252778053bcaaf": "8164bfe8fb89774a23333614b913cca6",
".git/objects/6a/89fcb2514c3927777a246a7b7d3152cdae4142": "f16cae5d7dc71f4d1d114d72ff3c5fe1",
".git/objects/6a/6bc91b7003e807d86e1800646314f0a544ae6d": "0e8a5608be1d0c10bccd30eb92fb2da8",
".git/objects/32/93271f30bd92867a6739179c2b6266b300f045": "462c22bbe2289bd6afa2cdcc271b53db",
".git/objects/69/70eb2d53cbb303d311ed21bdf88192e82fa4ed": "b03b4c61296b98b25ab4803a89479581",
".git/objects/69/9f3fca8f09b123e28f7c838e2ca5838ace10af": "539261a6a3e60bc9c966c6932d848b11",
".git/objects/56/e5458ae65557f45fc699ef05db33e3ff5ff53c": "1738392ad5e4795e51a5985109ba8a5a",
".git/objects/56/8cef4c20d9d34a7ae5637a4512afb85faf34b3": "a5ff9043a89af20ee6405e0486fcb3fb",
".git/objects/56/2cd7de72fd6db52d8a25cb9a42080f8197d7fe": "7674bb685d9db5507e857df018e527a2",
".git/objects/51/f2c52656c3fede82f4ae9cebf0021e29627601": "d01df7cee7dd7faafa9a43aa11489dd6",
".git/objects/3d/7258fb43805f0df4c57fe0a2d3b641caa12b0d": "0aa5317a02ca99ba17908691dfbdc4c3",
".git/objects/58/9569a103acc92f8823dc29a9c100ee491ce3b5": "544c55ed0337f1541e1c0992a6b6e983",
".git/objects/58/9fe800c17fd8c009562db2e4ec1aa35f3f8016": "ae0d4a41a52c569901c126754261ac6c",
".git/objects/94/1e6c002f3fcdfd4fcbbd4ddd197a51708bfbed": "e04f284bc6c0734fa723c3b2e8ef554a",
".git/objects/0e/ca491c82ab3acf5f241228426e2a7982ff8aac": "c983ff98fa6008b862b3e08b8628d702",
".git/objects/0e/36e2b1574de60c65bfc675f5f680f7f389250b": "ba8d53ed053db13b949ff2e44248bd1b",
".git/objects/5a/1dafb1cf8c4a0ef4204f280b44d0928f8dcd95": "629b745b73cbc41c4859f5252eea4ac0",
".git/objects/05/628f25d8663d3cbc82771abb5619d2812a5715": "f7e32fea6bc40d71b16d4d8f48180d2b",
".git/objects/05/b57088db7108989c2ab714bf8c1aaae5901fe0": "699a0b1dcafda56f1022e81651d898f4",
".git/objects/05/235e9205539fd60e91d42d4b8715f45a358b4d": "8fd18ef526a30db0bea3f779b06ba557",
".git/objects/9c/4ab4d48d627cec000e29d2af11da7239dabf01": "ed54b8405dbac325c7e44c6df4de92fe",
".git/objects/02/44338b15a6135061b30a448551d28c93e00440": "4cfca1711e08f042ec96082bcebdf630",
".git/objects/02/dbc4e4909ff6c83067fb3f9f12d221e817104b": "331b49b2952cbdadfc9298a508ec1209",
".git/objects/a3/6b06152ebcb3c78454c2262dc7ee36bc72bdb8": "86e9d01d466cd46200ec4d2710c4bc22",
".git/objects/b5/cade540caa2ea192ccac14fe9262ba118c941a": "b2ed5ab7176a012fae79e250b0569f65",
".git/objects/b5/f900461f738cb2b0b245c043afbf3f388ff39b": "74bf27e15b7de8f1c34f0bca289aacb2",
".git/objects/b2/b929b1786a7be5461781fc3abe77eaaa2f7649": "2b88d13d8ae495ac97168249f5964f6e",
".git/objects/b2/41a8203544089ce6d2f7bc60f496170d2d5aca": "fea3877b04d6cb0c79b18b5c93e270b0",
".git/objects/ad/b808511efc1c96becb41ca6300c3fe01bb1e5b": "bd5704dd3be41495bbe62f793c49340e",
".git/objects/b3/ee685869e0ee6ca72fe10c4cec8c0cbd744295": "74f99b9a933b305433fc57a38d997eba",
".git/objects/b3/af25056fc7ae362610874ecd29d54baf409526": "a095b41755617c301e48382112df4dc9",
".git/objects/df/6520583d49a1ab6d81c8309c874fae6bbb4434": "acb4609f347ae4b5c1da5bfcce07e017",
".git/objects/da/0ebf5e548c0880b3486b70faf6aaf9ad634d9e": "098ac8fa9899a2282d4ca2f0f7d9d250",
".git/objects/b4/be6b6841c6bb12d10fb6cb17900893ed80ebc7": "d10a539f097d6a5d6bea7ce4b9706e36",
".git/objects/b4/6a2b7aa55080425f1c44e00a38a4f97954ed6f": "5eb02f0b2806076e91eb8fa8fdc6d9c6",
".git/objects/bc/cc42034258fb8cbe3337fb5d6c0dff0f9b8af3": "17e4afde261a7cd1c657d7ca6816a9e7",
".git/objects/d8/23b470964f418d19c4c2d642d08209168a9978": "726ad91daa2245a7f85d43d6fa2c61f3",
".git/objects/ab/b0a57292a6b4565df5ca907b0b0dc0f785243c": "3c2e411a87c5fd79df0c5af5a5832284",
".git/objects/e2/6ce1206eb3e2afdbd370d310bf7306f639ba13": "0d04c4d40a19df3ec8927e4324651d9f",
".git/objects/e2/be0f8405e897f759d32422ca0a37eee816dae2": "ac6023e29760dc5c744e32fa85f60df0",
".git/objects/f4/3c8004c2cb007c3f692afdb5e273497fb7df29": "504ad974ba32223606ef621ce6fbf566",
".git/objects/f3/447d734dd864cad8641cf59aeb97d1f04dfeda": "f09afb8fa5e26e7c32e638b09a9efb72",
".git/objects/f3/8a983796d9c37f3ecd55c5d1aa41e5d6572e1f": "19eafbeb44f0a9879afb911726f3df1b",
".git/objects/c7/185ef0b980a6f8a8b0c4af8100330be7db222f": "033243a9bb41dbfd95cac0d8c4046701",
".git/objects/c0/d03107d1ad1505895df22d718687adece99438": "32b072aacc438f5fb2e7f10fdf68ac02",
".git/objects/c0/e2bb2ea146f04a9e3252649bf31375d31f6fce": "17be1895dbdf513cc590068267244920",
".git/objects/ee/7a10fe7f22dbf93cc45f4973762009a6e5055d": "ed1d4d45cd6425edeb576231c3f0f590",
".git/objects/ee/82eb57b1465243495562f7d5d84068a2d6446c": "c08703bf37c1509921077c81954c35ce",
".git/objects/c9/7312af8040b5715c94d79c9793b6c2387f9bf3": "c215e0a7759bc36f54ee7a89177c9c87",
".git/objects/c9/be485a9bf3fef835a11d52b0b5abbb73fd1bd3": "ce0ba2b9ba8c252e51c9116febe4b169",
".git/objects/fc/565ec170b7fd55cbf422b8188a6f64eddda60e": "c1d5b622c8e63d1865785872c9d4a21d",
".git/objects/f2/7a68e2fd5e44e4f00918072d4978ce3457f931": "dbafe5bb03fbeb3964ffd2852ad5788e",
".git/objects/f2/4bc73433996269805c3f215814ace7026d2870": "3a23422e3818573b67972afbd1d415e9",
".git/objects/e3/74157d94bff37afaff19ad3baf59a4f309c29c": "e4177887ec1cd7ed5b224b28f92de995",
".git/objects/e3/55f8aa700fe1fc8ecf20d065c0c5bf375f34e0": "f13cf77840353dbff5c7379bad055060",
".git/objects/cf/c5a7b3cfb5980bb6eda8ee8c6747729f094309": "f1713e6523f633cf3d8c9777c4d36a68",
".git/objects/e4/61cb443cbabee654d78ef62f73ce882dc6f39d": "257fb151408ddb64e07711d09d047447",
".git/objects/fe/b0cec37bce9b615f4dbaa163bdabeddbec00fc": "401945d47266ab63f230c4e8eee22e34",
".git/objects/ed/fb73cd0e8087dc3c1186cdd597f80d6ca47ba8": "fe772585e61773fd6dbfee1ab10a6d31",
".git/objects/ed/7a8b2558a4565b630126eb196d0d502a61e92a": "71201439c53428b2fd75bfbabee0baff",
".git/objects/c6/a68dec124835b9fe58933f4e40a7d9f3bb8b61": "d04cd88f7dfe3fff8909f6a3ceea62ef",
".git/objects/ec/64e84b9b4b85d77af272c5b76daa057b6d9571": "462ccaf15f3e97ac974449d75e307640",
".git/objects/ec/eceb568d6c6dd56d0bf82e7ec35c962c71f997": "ebfec723527a4c223176acc6ff8d7865",
".git/objects/ec/68c5eb5b24a5711affd71f3b9ab3587c8d3206": "c77b97e595159d5ffe234e6f2753277a",
".git/objects/4e/2dba908c16e11fd94e45d55b0fcbabb32a604f": "9e6edde8b9730ccee77f4dad5e725045",
".git/objects/4e/39835aacb1bfcdf2010fc520120143efc9ffa7": "87f689e8ae935da4f64f4c7d474a310c",
".git/objects/4e/35293965f04ac5ba03b393db20184939f0e9fb": "684433c56add1670c2027754c0849ee0",
".git/objects/4e/ccfe0fb2b76bbf052485ea398cba27ab745329": "6f2534b1069da3ae06ac47dfd32aa261",
".git/objects/20/5bb5db271c6d8de8399864c7bb9b917f638893": "c993b22f115d7f3ae6d5b7b212806539",
".git/objects/4b/3e0bd90da2af44d3b8810c37a312ba64cadb94": "f189fed468ea714a04ae6d09f29a9fd8",
".git/objects/4b/af84b274b4f1e93d12d967b8ab4dc2e5a923ee": "dab762c0c250fc2aedd5c291be3c4541",
".git/objects/4b/10d26b30959bab9b27274b84aba79e3cacc06f": "bbc6cff77dbb740a09aa6e686bf6cec7",
".git/objects/4b/ff019a44aa5b0f2bf1a4c3b4cf0adeeac82205": "aadf7827fbbf7124f31f77216ffdb50c",
".git/objects/11/eee871934c260ff558f2ae2fea814e111f1064": "3bc1897fa97b3996d2c894ad7f5560d3",
".git/objects/11/9e49dd2fd9f8a95d64a11bc843643533adf7b0": "0922b6cdb4d4de54e1078ce0a54c55d6",
".git/objects/11/143fb420aaff4acdac7d782b89c453d3cf9eac": "dbbab476c54e92f044518156dcb67a3c",
".git/objects/11/80446d1cb7d3f5fa6b98a9fdf2f372fc2fba87": "70684aa3e927126231b8fbd9e17763d9",
".git/objects/7d/c4ee65077b29820a26474991367718126af03f": "c676b5f4c407f22951f51bf7ecd89fbe",
".git/objects/7d/a1ac2b5d66d8b22e4c7bd3855ef604f9cb2d3f": "4ff5fc6815735175db47b4624d2ff1cb",
".git/objects/7d/d6f193e5813e931c67e43cc233f0753ef26dd9": "8f0b214745ac286927642182ec32ffb5",
".git/objects/7d/b21dd03651130ef0ea7304044454e33fca5050": "b644b564ecac5a0783200aef75ca194c",
".git/objects/7c/a2b30af5e44bb4aa7677e367227aa45ddda6a8": "389383dc791e3da3c44396c4c488e7b3",
".git/objects/16/169481f86e98db392772ae78bfeaefc4608fd2": "e0d0bc3d35a540bed9b4d5e112800402",
".git/objects/16/2abb07d19553ba45a7d8e352b44ba3e04366da": "800926efb662ad90a1da250b775f705b",
".git/objects/16/648c4dd7bcf43eb1e143fe5cae08d13e541b25": "a4dc853d41d8d6ca084a096b487f35b7",
".git/objects/89/e24ad6ced239ff6e24bc422216fbb4d09ee764": "e794a850ac78e339476987e5f4fab56f",
".git/objects/45/a7a1b240e74cc0143ea1e0f66285f1fd8ae3ba": "20bf5aaf4be8d2517f445a2768ba4786",
".git/objects/1f/83f8697b3f73fa203d089ac997c81cdf3bbe35": "362b6a88e2b37e4318e9e66e29be2713",
".git/objects/74/c89750b68de6d907d9e327d502d6281caf2f3f": "05c64f7c3324f9db2dff2adb897c0a3a",
".git/objects/1a/ab7532362b8400add162c4c1a9994351a19031": "98d3a994b5ba5c0377da9895814a42bd",
".git/objects/1a/09f6babbbb0b2fc9928d5f9a5cd49f4090f611": "1b203e4299ad0d7808cf325ec68a3e32",
".git/objects/28/c140aa31f3e2872f3690262fc6cb9fbab03746": "bf111647e43b0ed95dcb19e5b8f403d7",
".git/objects/28/7c323b6d669e7584ae5880ccdeb336d10f8979": "3e922280c3f4803e96c35e054f770f70",
".git/objects/28/fffc1cd99b4c30beb6b0daad03cccc6ca5821e": "60923e84666db55a61e9c2f89cc201d7",
".git/objects/28/28fc46f292ce8747251b03a10a9251c27c8d74": "1ffcf3550500720a374f778672768bbb",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/7e/eb83729632b46e754f5083ebf5d81356890c0c": "9a9d442d7648518a32bf5cab6c53cf8f",
".git/objects/7e/82b5936417434d183d1981e81dacc29e827c87": "511fa9d286d12bed4e527ed0d0b8d401",
".git/objects/7e/095e991d61e2633460b93e1b27888c64f54210": "1089ec091faf17ad2f8a5fc13af74b89",
".git/objects/21/a52c9d9e272ab5885cdec43f250cf48ca47196": "d150b99ff03f2d1780ae00b9fe9e55e7",
".git/objects/21/1a78566d0e007413e00192924d8a11dc1bea47": "9f17ee1d0f476ff367223ceb46735a82",
".git/objects/4d/09a88b168bf49ad9235e429ab0963073b02759": "8cf9d360ae07131fa5373b28526cdfcc",
".git/objects/75/906910cb06746185104245bf910860494daca5": "b6b89c3455f7a639268877527cbf89e8",
".git/objects/81/a5a62ac8b50a74cb401378453faf20d48eaa34": "952bab903274662ce7330570fd97e972",
".git/objects/81/0337fcab9374ea7916511a5b9b59c1fe38c5fd": "cc99e87ef5a5ad26f76eb93e555d98fa",
".git/objects/81/48ea6f4f1875dde55b4d036a7e75bb25603c69": "9ae5ae803240bf82d3969430106cd064",
".git/objects/86/b336af13a87b67b224f47bbd894349466a9b17": "0124dda911f728387df392994eb9d94a",
".git/objects/72/f5615e96330a6c52283dba11a801a459ea5aff": "d46dbb6db3bf12858608890c31c89a59",
".git/objects/72/87f2fe8c019b62eab18f83e2aabc10342b08e4": "80190874a2480fc04c2029a94dc3f1f1",
".git/objects/44/3e6b726b1cea53d36a24ae34189c603cad5e1d": "290fdc275b7fb9afba5513e88c84415c",
".git/objects/44/ed0b623bb2290f554d59209198f6c1576ee117": "6adf04f9e0ff0a8c3522d68f18e820c9",
".git/objects/2a/4d662a2c59c64d1ccf366e0c6a1c0cc7676983": "58b20fc561f05c5ef629bd72994f98ca",
".git/objects/2f/3fa569a026e4c81f6367f20a7050a265038635": "a0cff51985cba3fca35dd1155dc93bb9",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/07/314306f29c99587af9fb58675d39bd6d6ca370": "bd608ea6cbd2b40a8ee95feb4b96cd14",
".git/objects/07/f19f7dcefed1bc5dd5d84dd9b09004bc866242": "b239ad9ce21be77f76132e73953d8336",
".git/objects/00/917917e5ae2288850cd56d987c0a59d1c338d5": "12481cf3957f102eec968480073f8873",
".git/objects/6e/ac2bc4d2eb7aa547a0ecf36b5189e7469afce4": "f7f882c19f2197e23779d3b34e81d7df",
".git/objects/9a/f8560cfc2ded4145ef85cf93c9f8d59cdb00c8": "c02bde2d3f37cb62754a7142001fef32",
".git/objects/36/24775bab560eeadc064235cccd881d1d2997b7": "69ece7a0f1c2b1c690f3d13bf9f1cbcb",
".git/objects/5c/73026529c206801f0ff3e3e81770f73ac9b9d7": "4c24fc438f59d8010e8cb6b0fa1e9ffc",
".git/objects/5d/be84a5a0c6f7684f2253baadb9cc700f2877e1": "5b99f353086655e5269874eaa84b4c8d",
".git/objects/5d/fbdc3d74745207c454f81cb36bac39a07df2c6": "475bbb7be1d4d209ff09e5d41b55373c",
".git/objects/31/1546df60566d6f8011e299a62ae4a6de3c277e": "50443457eb35693bcb258d6cd3651953",
".git/objects/91/293e6f8c56ca231892a55244ecbd447cccd4bc": "cc28e4f3df8e235522d3f4075a731091",
".git/objects/91/0023ab942bd504a9e6101c104e2be564a511b0": "12249bb0916b6ee6f7c2de7c01f38afa",
".git/objects/62/f3939298e8a049f0f5652b72bcae097a0feea3": "f48cc94bc1d9c33232ba7c22beac57ab",
".git/objects/62/f464446d57acd037f5fa7571cebde3875527e0": "66a199a929e811a3da04d8214fd30909",
".git/objects/96/f5b92ec2c1bbf8cad517acfbc2fa55d08e91fa": "30224197571355624b38e81492e44631",
".git/objects/96/2aedea130a8e05e0eb556092151d162cd0c194": "1a72462da8498edbf44f18dfc32993b9",
".git/objects/96/96ff33d77b4e3112483d78b65496f7112a2f99": "afa9bef5c67b7fb4bc962beaf6c43067",
".git/objects/54/6ab2edc20a30fa9dc9ea423625bba4b435368d": "b121819eda89c2bb408e267977f8eabd",
".git/objects/53/34c54832d580fbf3f561e018dd6cfa000b0c53": "15e4911e997ba1f2c344225fc2caf664",
".git/objects/3f/4d9b9fd1e35290a8ec3ea4a7ded5d3d8319e4b": "316919fedbf4dd3e67413d59f4feaa43",
".git/objects/5e/cd117895b725919b130154596d24c690466d7b": "9db5573a019d921b78a9e2f82a0059e0",
".git/objects/6d/c114b4ac662256a94f61530d65b9bf9071a162": "239e53afee4d12850257cc59fc175ae6",
".git/objects/01/14fcceb7494a6be314dab265e5beb66aabfbaf": "8c204cbebeba4682e0ad6e20c25e09b7",
".git/objects/06/cee0383ea7a53b0fe494910e063ea82e6ad497": "94a255af83bb682cb19e24d546e907b3",
".git/objects/06/a9b956d2ab951524846cad54d15857fb93ba9a": "3f4ff07a084ab823ed08d794c4488cb9",
".git/objects/6c/f3fb088fd5cea1ed41b4f794e450f18838ff00": "691b06b20949cc0575ee8ba946a51207",
".git/objects/99/aa7bd62fe410ad163815d4fb2ccad25d318c34": "a18a166472ee19dbd339355cd112021e",
".git/objects/52/0db953c6a50cb40b482a03908b96404fd90b87": "01aa77d6f0f138ab73f64b2545fdaf38",
".git/objects/52/7d52542d9a262cb1ad82911b6e6bcc1fb55a0c": "a8155961c7b5fe5f0066e15bba0c5816",
".git/objects/55/7e4625a66f4e81db13e5958bf365e1536a37cb": "ebff5aeb4a54ee8426c3d415fc7b609c",
".git/objects/0f/816fb5068fb5d0dc1623718a94d7a34c5edfe4": "48392ce692d6328aef69a753fa305233",
".git/objects/0a/728ae8c3bc6642acae1e0f3fccbf65cb0aadb2": "d82747cf9ec0f12dfebc251b626b8708",
".git/objects/0a/0a26ad7fe9778e3473d675b84c449701256e50": "0ed69094a2c0abc24a8694f0c5cab487",
".git/objects/0a/920142089ab20aa1ffe311a514fe309de10cf3": "86e7cc8b042d36916718ab49afeb021e",
".git/objects/0a/a2140ec8e63a9c572a3e2bf502c68fd4a07e50": "91ba1211277d7ab7c6e7ec49e8dcabb1",
".git/objects/64/8fa31d78987cd1d1adaceed801805f0d31710f": "7ae80e2e376a1640ff4564fe045a996e",
".git/objects/90/e106559a5c6c7f64d3eddb713c07f708885a84": "de3d66ec276da10bef2d628af9703252",
".git/objects/90/d14fd2acfbeb892e23213bf0f19e75566cc56b": "01b56ed07221ec9366c0a33d3ef01e2d",
".git/objects/90/122a003246d6c00e789dff0f89bcd61c527a1c": "fa4f1736bec04ec3e293d0a75a03e2d5",
".git/objects/bf/d699db26a116a682f3d2cb4869623878cdc60d": "3180412410a77c0ae5786ca49e2629b9",
".git/objects/d3/201aca73c44021d202046abb794d94085d8c1a": "c3149eb30dfb6d89ffcbc1a1340f5679",
".git/objects/d4/5373cb29bbfa234c506447e3da0e9b04bef81c": "470ef6153991b12d0af5f103ae37d9f4",
".git/objects/b8/166dd775b71d58e4dc2ac73498f109fd357ef5": "e44c68e9c6a43f588bac54746651d594",
".git/objects/b8/627dee229140daf7ea2d326a6c5224fa081ba6": "06ff51033bc7ee99adce28d25e8897b9",
".git/objects/dd/6ef2ab57441ec847cd422a5858488629cd235a": "427ea0dfcedecc528aaa493f68c636f1",
".git/objects/dd/447058ea93bbfd8df6ab215eeef0de992eab0f": "faed299cc9e8ee722a5e8c7bc910ae57",
".git/objects/dd/c2915e02e4d179d18884da0baa68d4f0a364f5": "e18481220bb54a3f1e16540af5977177",
".git/objects/dc/ab6ff483f5c89dc91becf19e7ea937a3042c0f": "477c124ac22b70d79d9b857acefbb9e8",
".git/objects/dc/691e4a1a38ca5ad4fb7a5b797ba7fc6cd09f5d": "0e134e8592ee98a6122a50a1d4d7115a",
".git/objects/dc/6451e56c30f5ff2b0239ef599e81a6e453f5f7": "26b89357569ce4619b6e264e97f528a2",
".git/objects/dc/cb1c4687f157cdd203d09c65e58882143e2a0f": "5b3cf01acbaecd8e59125a00becad58d",
".git/objects/b6/e2fd40f1aef776d7cf725139b405072248d574": "cc2a04b88194a466af8ff4a6417149e4",
".git/objects/d5/7ee4783ed8434588582d82df8e26ca3e8cd153": "8ed22c24295af4a096e96c963db25cbf",
".git/objects/d5/99aaa96a1dff4d5000191c7afa803fa6ed3aab": "0e87621d8e97eb58251357573e6ab66b",
".git/objects/d5/ab85e77774f9606acf3ec9dc91134959396427": "37cf3b9dfca8f72f1fdb7aa19f5e14a4",
".git/objects/d5/fab6a84725d55efbb73113baa65838d834fe69": "a44e2b3684618d4e609c051862177b8e",
".git/objects/aa/c7107bceefa95a3a1120701cbbfaa48f0b4879": "b3699f0cf002296e738f5d1e84529a4b",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b7/e563e96e5bd75cb174ec2a08351fe16881fb8d": "4726885bcbc3fe7eeb538c6416061b91",
".git/objects/db/4f10c1856e40d3fcfc6c454485fb17b8043c50": "72ece22509219e7ec759fa337bccdb83",
".git/objects/db/b067f3162325f158eb260089307bcbde4ed4ca": "29b3661d0021201cd627c1bc365adbef",
".git/objects/a8/69eec5c7013f3d2c2cb815778b8ae9270c4e29": "878d3b045ba9c888b06c087247443ed0",
".git/objects/de/7c164e41429ec1f7f80e0ad929d279c78de4d4": "7ad823d86c65aead1b2356df94857877",
".git/objects/de/9235ad8d5c94517d2e3dcb39135e1348651fb2": "edd28f251b50e7bc7d6eca349620da15",
".git/objects/b0/40373c4b2e34824a010502f68de6cfa622cf3e": "fa087a99a2b1aa0ab5e2aa36942ae304",
".git/objects/a6/ab6c16eb089d4695d62a6bb8863447d0ae6336": "dcdfda43adee1ec03a62098ade610ac6",
".git/objects/b9/570212269ee712f9662984911d0dc1eefadb2e": "bfe0213ff773d0007c876af75ee21e5f",
".git/objects/ef/d91040f291cb824e41d15de4498992a5c62e74": "25743e1b06b68676472f077d3b1522a7",
".git/objects/c3/df544709dd7360e59edb42b540b9c10c1d774b": "48491d6dddb31e724bf44cb68fae464c",
".git/objects/c4/055c849a7021d195dad151a104f18b4d6eb974": "141c571f6327d5ec67f117205f3d07fc",
".git/objects/e1/3a408121bb12740067c40c535dad891fe8133d": "826d95be3251a310740575e0ed567e89",
".git/objects/e1/1ecc79f9c639bd3a04295493902aaee44856e6": "e06f9de2fe589b621a79cc42f93dc8d4",
".git/objects/cd/69b369935dbcb6404f4b760f3a5531b39b4f6d": "0a8f51307d7b550f08e6d1b1ca68bfe3",
".git/objects/e6/e1d7f09ce9fa8ed9fefc08dcbb22378d0bb366": "629e032018aae3ee23ebe7b57618257d",
".git/objects/e6/85623f8bed133b00865d67482754f109e63b9e": "3926ff71e843eb9353c2b5a1d2401213",
".git/objects/f9/2ad5c825bbceff40028e1819a54227340ebc7e": "4aa4c35bbadeadf4d85401eefb96d350",
".git/objects/f0/7a90c03276e80de7d42bce329bb67cc92690ff": "83edeee69afe3142116ed5305737b255",
".git/objects/f7/418f246d78367422adf130dfaa53a302520a70": "863af70956fb7feb80afb41a06302e5f",
".git/objects/f7/8bda960a39b3a3703861ceb9fcf39fd1d9b737": "c0efa2fd592deee9e8c83db030ad36ee",
".git/objects/e8/9efe52a152b99abcd2dfb0b914424b20e9cae4": "b37b91a1f87e78427977bd9c349dea15",
".git/objects/e8/ba407b6d96e089a59187fc2fffcf321f4904fb": "611b63449ebe4e2cf538ce488a5a72fa",
".git/objects/e9/586397aedef2a95cae292feb72e34496feae9a": "016550cc8d0427dd4f5fc704ac457e71",
".git/objects/cb/b3bcc0450946c408d12d7b056e5f0521b7bd3d": "4fe0dbd332bece58b883a27fe760bdb4",
".git/objects/ce/ad6166d44eed56f4e84cc7a0d6828f26b2b251": "d8ddc7a34181470616441d11e70f21d0",
".git/objects/ce/f80762dc3e8d13a3e96f72c26609faf6fc2ba6": "fa1155bc241fd94cfca1ed46170d0bfa",
".git/objects/ce/3283503102ea382007cf86f979d90fd5db8f7a": "931e1c3f7c124fb5d5f3e13ef4e46fb5",
".git/objects/ce/cbf9b542c9b8a08e301653c0d52fad0c0912eb": "426a9b6beacc346f37f63bece99a96e2",
".git/objects/e0/2191548bdc7eb7fe922674cdd3be0052fe00cc": "3da6c584aa6035c9cfb2b3082f6e9a73",
".git/objects/e0/f5051ce91d7bcc497ceb9928cb9f3528654eec": "5f54de18144f0e78eeba68d2b41a9a4d",
".git/objects/e0/29740e18d4aa1a096fadee6126247b1ce82643": "31932b3b38d9f5662d3ea83b057891f3",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/46/1ab30d08cc217be3ad7715ccb653e92e21821a": "e350b870a871fe4500bd4d068818c482",
".git/objects/46/403343ee8d3336e4282e97aa015ba52f224eaa": "10f22c45bf847a81dde629b098981a4d",
".git/objects/46/ab51ab53ae9880d9692c066841fb68cd8f33fc": "27cac15f6da0823f1bad71f52facf7d5",
".git/objects/2c/851dcc4585f8d471a7bb7f3eb06c31d58fd4d4": "acbf2b2ec489662e73f327212f12e7ed",
".git/objects/79/44158cc8efafe3c5d1d7fea90345696b164ee5": "4e350900d87762876dbff06a65e3c473",
".git/objects/2d/5aa2d18738835018f584c9bc64c3a06725c6b2": "fb436ff868ecc1bf18a85b74211d8535",
".git/objects/2d/0dbbb5ce196c9b4ffdad9ba5f6a5026a905838": "ec7cccf164c94b717609a6c03440d2db",
".git/objects/2d/c18a831eeb349ca48c5ee5f8578db2b5681d49": "fc20cd35a169932f2f95f550468a8aa6",
".git/objects/41/eb6ee6545278883534d33be7afc695ba841065": "30cb9988534d18cda08a789659e07a76",
".git/objects/41/77ea4fda9221301fbf9032f93eb5b8d082d3c8": "81c901d175cd8d5a0ee35f58ebb2db65",
".git/objects/83/4c0661d6ca561aa8bf1c860fbdd78be69134a7": "9ef35e327f12777b663c489df7a5dd51",
".git/objects/1b/d2320f802ac9484564a426b9d5c01e478bb152": "7d0a5777eb79de364f5205093dddf5de",
".git/objects/77/4ebff18414f43071c39d4a7675b971d5aadde4": "d675500ae8f638300c0d4ffbbe03859e",
".git/objects/70/000d6f2d603775a921d6f8de37cfb3046c945d": "03ccf3713f06e729e6f90832149ed3d6",
".git/objects/70/f55e666cfa521addd7a1e6b001fe9e5a0247c7": "0b06db9ffa85256ee5f53bd27e384b43",
".git/objects/1e/d69b8d223c0e236f047f220fe02081f0d1f677": "4fb640c121b4f7cb3a1bcb5eb9841856",
".git/objects/84/eed9e0ecfe69aae6d57e1cab4ee99a12944f5d": "afbafa63fda419fc843f559921c87045",
".git/objects/24/771fa4376f1976d835c4d60b9e36cdc0f51c34": "a33c720f7246b1c5e39a9a10e88308c9",
".git/objects/24/38b4312789b1106473b576a190917b34d05616": "80f074fd35e44eac62009a69396a6f7e",
".git/objects/8d/1ea61f3946c7cf15c40e8e24cb71676372e45a": "86e9b8db7c924232792530b63e69368f",
".git/objects/8d/24614e8dc94aec8a3f03ac97e2829053427f1f": "37358159aed07fec90b9b13edd5d161b",
".git/objects/15/500d1669495dd2a63dba69bb793209080aba03": "abda842d6b61599967482892c32f80c9",
".git/objects/15/9b15011009e1e691b0761e5627dc3f3aa452ad": "822c0ced8e90203ed87ff7e0082d7945",
".git/objects/15/c6af2def4616fe83abc70327ab963e1954b7cb": "ab8662a92b1457166aac8f24cbe8af29",
".git/objects/12/a0b31f4b1dfb5c34281474c49910e5b475e8bc": "fe3e65a0e9ca17947f1d5062eb71f4dc",
".git/objects/8c/70c7f64389695eb1b0800c4fc138f24dd233ae": "f134691f50c3b647d8715d95bb2aee5d",
".git/objects/85/d44d5df86ea622eaa994aafe4ac414387dccc1": "014366d4e0f6d1fe501536934a47079b",
".git/objects/1d/8c9852b95cb25d98fc46a7dd3e3d919e06e862": "476700559c68eb6348a0bd363a492437",
".git/objects/1c/87abbcbfe488e481704eba8ecaf44bf4cc3094": "d1a1775a5f47488b3dae9d45cbeca754",
".git/objects/1c/fe5f202d8c554e4788224f45f97042e040d8fe": "e4a339c22560621dae76bf7e232ef969",
".git/objects/40/55b3c2779e8488cec08d35d1330db571d65a80": "4f921189e4d867228a0b90d9deb6abd2",
".git/objects/2b/e5d67a2b6d04a3baf2c66359729de14a174140": "91e4fa60c03cadad965236da0c10209e",
".git/objects/78/34d2c52a6cf8e763ae3d1283adb7f1db8c85cb": "65fdd9d495f29bc649dd34de45896edf",
".git/objects/78/7851082de690128a5cfe6edf31e9705b33e023": "ef0163a8341b58554cd37a5c6658acbb",
".git/objects/78/2eb33e79e146fa202a095e5082bbd978df549a": "266ac1dfd20914b9071604bc00748c17",
".git/objects/13/aa9dce69b6449dc8cf76a3ac72be424f8be7ca": "59af0b64d4af569133d18226d8d1f72c",
".git/objects/7f/ef388f1b58fcbec7060c2cb75a812249473f71": "f3a79befcc973c12b4b39997cc85bca0",
".git/objects/7a/c365f2fd81c8ab8f178e0ad019dc9277f28705": "b36c306df8f3795aabc5fd66625ac830",
".git/objects/7a/0cba67ce04b40b5a02c2f3d609b3ddacb6ce99": "ed2a62f62323bf190df51ed467b5329e",
".git/objects/14/31e18cf28a50b4b3f94847c711c37581f3215f": "b0996de098d30517bdcc5b0180e8fd30",
".git/objects/8e/ca5d487099999124e9d90ce57a8572f6276ead": "af263e666425e4c148a255fdf38b12df",
".git/objects/8e/4ee87d8f7fd87027e0fbfbd995aec4dad7ae71": "21c73ecd14d102ea5322e0ae4eec9569",
".git/objects/8e/ba74f9dc99722514973b460a59356ac4c2559e": "fbd55d46cc2dd2ff1bc325b2368c4677",
".git/objects/8e/71eff013408e8d90d26b1ecbb69306d29cf879": "eb9f6314072ed796f6d7ce4b64dd64d2",
".git/HEAD": "4cf2d64e44205fe628ddd534e1151b58",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "aeef12c7a13b201b013f22a674382521",
".git/logs/refs/heads/master": "f3fdc510dab0d5823b7c7c0908d50914",
".git/logs/refs/remotes/prestoqr/master": "8ab447a55f642be102ae1130aa1c4fce",
".git/logs/refs/remotes/origin/master": "a2c5da6289d7714b4c247bbcd2917b7b",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-commit.sample": "e4db8c12ee125a8a085907b757359ef0",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "ecbb0cb5ffb7d773cd5b2407b210cc3b",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "3c5989301dd4b949dfa1f43738a22819",
".git/hooks/update.sample": "517f14b9239689dff8bda3022ebd9004",
".git/refs/heads/master": "efdf65098109fe38d6d69efd3fb5869c",
".git/refs/remotes/prestoqr/master": "efdf65098109fe38d6d69efd3fb5869c",
".git/refs/remotes/origin/master": "5bc60fda67f2d6d74ce69f7db699a36e",
".git/index": "c0cc388c1909f31334c88fdcae4433cc",
".git/COMMIT_EDITMSG": "e5127c736ba98d43a3f0de85e1ce081b",
"assets/AssetManifest.json": "157ab6a2f3119c68aa5d48849ec755ad",
"assets/NOTICES": "a57f3cc2345e291155fd31091ba8df55",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/fonts/MaterialIcons-Regular.otf": "a68d2a28c526b3b070aefca4bac93d25",
"assets/assets/images/gb1.jpeg": "4a5e2808faea27f22e829b60d2307be5",
"assets/assets/images/logo.png": "aa72bf67330469cb8ea46ad4e299c7b6",
"assets/assets/images/bg2.jpg": "22fca86c34fda559be30bb254b14b45e",
"assets/assets/images/qr.png": "f8c8f7e7a7b18717dbb64180021d24d1"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    return self.skipWaiting();
  }
  if (event.message === 'downloadOffline') {
    downloadOffline();
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
