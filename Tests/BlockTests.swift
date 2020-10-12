import XCTest
import Tron

final class BlockTests: XCTestCase {
    private var tron: Tron!
    private let list =  [
        "about:blank",
        "about:srcdoc",
        "https://sourcepoint.theguardian.com/index.html?message_id=343252&consentUUID=4debba32-1827-4286-b168-cd0a6068f5f5&requestUUID=0a3ee8d3-cc2e-43b1-99ba-ceb02302f3e5&preload_message=true)",
        "https://tags.crwdcntrl.net/lt/shared/1/lt.iframe.html",
        "https://elb.the-ozone-project.com/static/load-cookie.html?gdpr=1&gdpr_consent=CO7HiBtO7HiBtAGABCENA7CgAP_AAEfAAAYgGStT_S9fb2-je_59d9t0eY1f9763tewjhgeMs-4NwRuW_J4WrmMyvB34JqAKGAgEujJBAQdlGGDcBQgAgIkFgTLMYk2MiwNKJpJEClIbM2dYGC1PnUVDuQCY7E--Pvrzvl-6-3__YGSEAGAAKAQACGAgIEChUIAEIQxIAAAACggAAoEgAAAgQLIoCOEAAABAYAIAAAAAggAIBAAIAAEBAAAAAAIAAARAIAAQACAEAAAAAEEABIgAAACAEhAAAAAKAAAUAAAIAgAAAAAZ3QDxkAsAFQATABHADLAGoAPwAjACYgE2ALRAWwNABABmAY8IgJAAqACSAFYAZYA1ABsgD8AIwAUsA1gB8gENgIvASIAmwBOwCkQFyBIFQACwAKgAZAA4AB4AEAAKgAYABEACSAEyAKoArABYADeAHOARABEgCaAFKAMMAZcA1ADVAGyAPiAfYB-gEYAMUAawA2gBuAD5AIbARUAi8BIgCYgEygJsATsApEBYoC2AFyBQAYARwGMgMeDQEwAVABJACsAMsAagA2QB-AEYAKWAawA-QCGwEXgJEATYAnYBSIC5AGMCoCAAKgAmACOAGWANQAfgBGACOAFLASCAmIBNgC2AFyALzAZEOgSgALAAqABkADgAIIAYABiAD4AIgATIAqgCsAFgAMQAbwA5gCIAE0AKUAagA2QBvwD7APwAjABcwC8gGKANwAdMBDYCIgEXgJBASIAmwBOwCxYFsAWyAuQeAFACOAioBjMDHAMdAZEQgJgALAAyADEAJgAVQA3gCOAGoAN8AfgBGADFAJBASIAmwBYoC0YFsAWyAuQiABAY8SgLAALAAyAByAGAAYgBEACYAFUAMQAbYBEAESAKUAaoA2QB-AEYAMUAbgBF4CRAE2ALFAWwTACABHARUAxkBjxSA6AAsACoAGQAOAAggBgAGIARAAmABSACqAFgAMQAcwBEAClAGqANmAfYB-AEYALyAbQA3ACLwEiAJsATsAsUBbAC5CoAUAHwARwGMgMeAZAA.YAAAAAAAAAAA&pubcid=8d865511-91a7-4b5a-bc49-e15dbdce494c&publisherId=OZONEGMG0001&siteId=4204204209&cb=1602421568472",
        "https://ads.pubmatic.com/AdServer/js/showad.js#PIX&kdntuid=1&p=157207&gdpr=1&gdpr_consent=CO7HiBtO7HiBtAGABCENA7CgAP_AAEfAAAYgGStT_S9fb2-je_59d9t0eY1f9763tewjhgeMs-4NwRuW_J4WrmMyvB34JqAKGAgEujJBAQdlGGDcBQgAgIkFgTLMYk2MiwNKJpJEClIbM2dYGC1PnUVDuQCY7E--Pvrzvl-6-3__YGSEAGAAKAQACGAgIEChUIAEIQxIAAAACggAAoEgAAAgQLIoCOEAAABAYAIAAAAAggAIBAAIAAEBAAAAAAIAAARAIAAQACAEAAAAAEEABIgAAACAEhAAAAAKAAAUAAAIAgAAAAAZ3QDxkAsAFQATABHADLAGoAPwAjACYgE2ALRAWwNABABmAY8IgJAAqACSAFYAZYA1ABsgD8AIwAUsA1gB8gENgIvASIAmwBOwCkQFyBIFQACwAKgAZAA4AB4AEAAKgAYABEACSAEyAKoArABYADeAHOARABEgCaAFKAMMAZcA1ADVAGyAPiAfYB-gEYAMUAawA2gBuAD5AIbARUAi8BIgCYgEygJsATsApEBYoC2AFyBQAYARwGMgMeDQEwAVABJACsAMsAagA2QB-AEYAKWAawA-QCGwEXgJEATYAnYBSIC5AGMCoCAAKgAmACOAGWANQAfgBGACOAFLASCAmIBNgC2AFyALzAZEOgSgALAAqABkADgAIIAYABiAD4AIgATIAqgCsAFgAMQAbwA5gCIAE0AKUAagA2QBvwD7APwAjABcwC8gGKANwAdMBDYCIgEXgJBASIAmwBOwCxYFsAWyAuQeAFACOAioBjMDHAMdAZEQgJgALAAyADEAJgAVQA3gCOAGoAN8AfgBGADFAJBASIAmwBYoC0YFsAWyAuQiABAY8SgLAALAAyAByAGAAYgBEACYAFUAMQAbYBEAESAKUAaoA2QB-AEYAMUAbgBF4CRAE2ALFAWwTACABHARUAxkBjxSA6AAsACoAGQAOAAggBgAGIARAAmABSACqAFgAMQAcwBEAClAGqANmAfYB-AEYALyAbQA3ACLwEiAJsATsAsUBbAC5CoAUAHwARwGMgMeAZAA.YAAAAAAAAAAA",
        "https://js-sec.indexww.com/um/ixmatch.html",
        "https://ssum-sec.casalemedia.com/usermatch?gdpr=1&gdpr_consent=CO7HiBtO7HiBtAGABCENA7CgAP_AAEfAAAYgGStT_S9fb2-je_59d9t0eY1f9763tewjhgeMs-4NwRuW_J4WrmMyvB34JqAKGAgEujJBAQdlGGDcBQgAgIkFgTLMYk2MiwNKJpJEClIbM2dYGC1PnUVDuQCY7E--Pvrzvl-6-3__YGSEAGAAKAQACGAgIEChUIAEIQxIAAAACggAAoEgAAAgQLIoCOEAAABAYAIAAAAAggAIBAAIAAEBAAAAAAIAAARAIAAQACAEAAAAAEEABIgAAACAEhAAAAAKAAAUAAAIAgAAAAAZ3QDxkAsAFQATABHADLAGoAPwAjACYgE2ALRAWwNABABmAY8IgJAAqACSAFYAZYA1ABsgD8AIwAUsA1gB8gENgIvASIAmwBOwCkQFyBIFQACwAKgAZAA4AB4AEAAKgAYABEACSAEyAKoArABYADeAHOARABEgCaAFKAMMAZcA1ADVAGyAPiAfYB-gEYAMUAawA2gBuAD5AIbARUAi8BIgCYgEygJsATsApEBYoC2AFyBQAYARwGMgMeDQEwAVABJACsAMsAagA2QB-AEYAKWAawA-QCGwEXgJEATYAnYBSIC5AGMCoCAAKgAmACOAGWANQAfgBGACOAFLASCAmIBNgC2AFyALzAZEOgSgALAAqABkADgAIIAYABiAD4AIgATIAqgCsAFgAMQAbwA5gCIAE0AKUAagA2QBvwD7APwAjABcwC8gGKANwAdMBDYCIgEXgJBASIAmwBOwCxYFsAWyAuQeAFACOAioBjMDHAMdAZEQgJgALAAyADEAJgAVQA3gCOAGoAN8AfgBGADFAJBASIAmwBYoC0YFsAWyAuQiABAY8SgLAALAAyAByAGAAYgBEACYAFUAMQAbYBEAESAKUAaoA2QB-AEYAMUAbgBF4CRAE2ALFAWwTACABHARUAxkBjxSA6AAsACoAGQAOAAggBgAGIARAAmABSACqAFgAMQAcwBEAClAGqANmAfYB-AEYALyAbQA3ACLwEiAJsATsAsUBbAC5CoAUAHwARwGMgMeAZAA.YAAAAAAAAAAA&s=184674&cb=https%3A%2F%2Fjs-sec.indexww.com%2Fht%2Fhtw-pixel.gif%3F",
        "https://tpc.googlesyndication.com/safeframe/1-0-37/html/container.html",
        "https://c219afb78bb1f379b2758d73666870e6.safeframe.googlesyndication.com/safeframe/1-0-37/html/container.html",
        "https://vars.hotjar.com/box-469cf41adb11dc78be68c1ae7f9457a4.html",
        "https://reuters.demdex.net/dest5.html?d_nsid=0#https%3A%2F%2Fuk.reuters.com",
        "https://mafo.adalliance.io/",
        "https://ad.yieldlab.net/d/7053789/631/2x2?ts=0.32566239883440873&type=h&consent=CO7HjPDO7HjPDAGABCDEA7CgAP_AAAFAAAYgGQAR5CoUTGFAUXB4QtkAGYQQUAQEAWAAAACAAiABAAEAMAAAAUAAoASAAAACAAAAIAIBAAAACAAEAQAAQAAEAAAAAAAAgAAIIABEAAAAAAAAAAgAAAAAAAAAAAEBAAAAkAAAAmIEC2oAQAcgFtAHjIAgATAAuAEcAXmIgDABcAEMAhsBF4CRAFDhIDgACwAKgAZAA8ACAAGgAPAAiABMAC4AG8AOYAhABDAClAGGANUAfoBGgCOAGKANwAegBDYCLwEiAKHAXmEAAgBPDQBgAuACGAQ2Ai8BIgChwwAEA6gqAIAEwALgBHAF5joDoACwAKgAZABAADQAHgAPgAiABMAC4AGIAN4AcwBCACGAEwAKUAaIA_QCOAGKANwAdQA9ACGwEXgJEAUOAvMcAHACeAF8AiwBdQDAgGvARAQgFgALAAyAEwALgAYgA3gEcAMUAdQA9ACRCAAIAL4BdSUBIABYAGQAeABEACYAFwAMQAhABDAClAGqARwAxQBuADqAIvASIAvMkADAC-AXUA15SAwAAsACoAGQAQAA0AB4AEQAJgAXAAxABzAEIAIYAUoA0QBqgD9AI4AbgA9ACLwEiAKHAXmUADABPAC-ARYAuoBigDXg.YAAAAAAAAAAA",
        "https://spiegel.demdex.net/dest5.html?d_nsid=0#https%3A%2F%2Fwww.spiegel.de",
        "https://widgets.sparwelt.click/widget?widget_id=23789",
        "https://adstax-match.adrtx.net/activation?receiverId=adaud",
        "https://gum.criteo.com/syncframe?topUrl=www.spiegel.de&gdpr_consent=CO61zsyO61zsyAGABCDEA6CgAP_AAAFAAAYgGQAR5CoUTGFAUXB4QtkAGYQQUAQEAWAAAACAAiABAAEAMAAAAUAAoASAAAACAAAAIAIBAAAACAAEAQAAQAAEAAAAAAAAgAAIIABEAAAAAAAAAAgAAAAAAAAAAAEBAAAAkAAAAmIEC2oAQAcgFtAHjIAgATAAuAEcAXmIgDgAXAC4AIYBDYCLwEiAKHCQHAAFgAVAAuABkADwAIAAaAA8ACIAEwALgAbwA5gCEAEMAKUAYYA_QCNAEcAMUAbgA9ACGwEXgJEAUOAvMIACACeAokNAHAAuAFwAQwCGwEXgJEAUOGAAgHUFQBAAmABcAI4AvMdAeAAWABUAC4AGQAQAA0AB4AD4AIgATAAuABiADeAHMAQgAhgBMAClAGiAP0AjgBigDcAHUAPQAhsBF4CRAFDgLzHACAAngBfAIsARoAuoBgQDXgIgIQCwAFgAZACYAFwAMQAbwCOAGKAOoAegBIhAAEAF8AupKAkAAsAC4AGQAeABEACYAFwAMQAhABDAClAI4AYoA3AB1AEXgJEAXmSABgBfALqAa8pAYAAWABUAC4AGQAQAA0AB4AEQAJgAXAAxABzAEIAIYAUoA0QB-gEcANwAegBF4CRAFDgLzKABgAngBfAIsAXUAxQBrwAA.YAAAAAAAAAAA#%7B%22optout%22:%7B%22value%22:false,%22origin%22:0%7D,%22uid%22:%7B%22origin%22:0%7D,%22sid%22:%7B%22origin%22:0%7D,%22origin%22:%22publishertag%22,%22version%22:98,%22lwid%22:%7B%22origin%22:0%7D,%22tld%22:%22spiegel.de%22,%22bundle%22:%7B%22origin%22:0%7D,%22topUrl%22:%22www.spiegel.de%22,%22cw%22:true%7D",
        "https://interactive.spiegel.de/int/pub/common/img/pixel.gif",
        "https://datawrapper.dwcdn.net/IoE9j/223/",
        "https://googleads.g.doubleclick.net/pagead/render_post_ads_v1.html#exk=1306804804&a_pr=11:TPeIK7Weg7.lb3KjNhYf7fSugAMSGF693F5KAw",
        "https://imagesrv.adition.com/banners/268/00/b3/65/06/index.html?clicktag=https%3A%2F%2Fde7.splicky.com%2Fclk%3Fmid%3D8805366030483347127%26aid%3D406208%26url%3Dhttps%3A%2F%2Fad4.adfarm1.adition.com%2Fredi%3Flid%3D6882352274847564137%26gdpr%3D0%26gdpr%5Fconsent%3D%26gdpr%5Fpd%3D0%26userid%3D6882352274847433065%26sid%3D4573083%26kid%3D3887752%26bid%3D11773239%26c%3D23805%26keyword%3D%255Bu%255Dtheguardian.com%255BIDFA%255D%255BAAID%255D%26sr%3D0%26clickurl%3Dhttps%3A%2F%2Fad2.adfarm1.adition.com%2Fredi%3Flid%3D6882352274857395416%26gdpr%3D0%26gdpr%5Fconsent%3D%26gdpr%5Fpd%3D0%26userid%3D6882352274857264344%26sid%3D4534627%26kid%3D3865979%26bid%3D11756806%26c%3D13762%26keyword%3DPACS%255F4573083%255F11773239%26sr%3D0%26clickurl%3D&gdpr=0&gdpr_consent=&h5Params=%7B%7D",
        "https://us-u.openx.net/w/1.0/pd?cc=1&plm=10&ph=bbb82fae-1d27-4d90-bb10-e24164ecd7bc",
        "https://imagesrv.adition.com/banners/268/00/b3/65/06/index.html?clicktag=https%3A%2F%2Fde7.splicky.com%2Fclk%3Fmid%3D8805366030483347127%26aid%3D406208%26url%3Dhttps%3A%2F%2Fad4.adfarm1.adition.com%2Fredi%3Flid%3D6882352274847564137%26gdpr%3D0%26gdpr%5Fconsent%3D%26gdpr%5Fpd%3D0%26userid%3D6882352274847433065%26sid%3D4573083%26kid%3D3887752%26bid%3D11773239%26c%3D23805%26keyword%3D%255Bu%255Dtheguardian.com%255BIDFA%255D%255BAAID%255D%26sr%3D0%26clickurl%3Dhttps%3A%2F%2Fad2.adfarm1.adition.com%2Fredi%3Flid%3D6882352274857395416%26gdpr%3D0%26gdpr%5Fconsent%3D%26gdpr%5Fpd%3D0%26userid%3D6882352274857264344%26sid%3D4534627%26kid%3D3865979%26bid%3D11756806%26c%3D13762%26keyword%3DPACS%255F4573083%255F11773239%26sr%3D0%26clickurl%3D&gdpr=0&gdpr_consent=&h5Params=%7B%7D",
        "https://interactive.guim.co.uk/uploader/embed/2020/09/archive-3-zip/giv-3902xoR671UFuHsK/",
        "https://www.googleadservices.com/pagead/aclk?sa=L&ai=CLGUYOgmDX_nYCJ6X3gOM1ZLIA5eSusRfnvKlk-4L6oywtOgOEAEgvJbhEGCV-vCBjAegAfyLlJkDyAEJqQKBfdTrMdezPuACAKgDAcgDCqoEhwJP0Hm0OWQjz_4hTx4y0D1nPtIFf3PVwEOxv-V2umIiqwqE5hRf0Q_1m571JayrTsETuW4XPeC28aLdv2I6EQ3mIRUa8ckR5xJBWTvNBTqotBvYNDhaVTwu9dG2pcZg_FLHsUiKT5w649rB2476XvLoxiFkJqWUrx2hzDjMlp8zGx0PtcQNTU5wgy6u-OaRvc0LUFo-r90wWjAwtXbBA0yS0nJiUzpqCrLbPUeXJrv3dmBcngmQDfRVRRwFKKEXo1eSMXsh_mEXQg2BQSXtdjGwu1aXdsa4bSUn20Brwovrzt5oZd6N1W4xYZak98w-YXwkMsPP7VL1Yeyt7iTf4IJPoiiYi_d7VsAEivLc-IkD4AQBiAXc7N2pJ6AGLtgGAoAH7PPrZqgHjs4bqAfVyRuoB5PYG6gHugaoB_DZG6gH8tkbqAemvhuoB-zVG6gH89EbqAfs1RuoB5bYG6gHwtob2AcAoAiMhqkEsAgC0ggJCIDhgFAQARgdsQkoheo0SI0_QYAKA5gLAcgLAYAMAdgTDIIUFRoTd3d3LnRoZWd1YXJkaWFuLmNvbQ&num=1&cid=CAASPeRoRf5K8aIm1K7aLPaj00RNvviOn1VMnv-Y3i2rXsRp4bfbGaYQZ34ywrAINz0op0HxF-Cv9NyR9M77K30&sig=AOD64_395HuIOkm6CGxGyO0b4nhzEuv9Rw&client=ca-pub-2012933198307164&nb=9&nx=186&ny=128&adurl=https://www.aroundhome.de/solaranlage/formular/%3Futm_source%3Dgoogle%26utm_medium%3Ddis_gdn%26prid%3D30%26meco%3Dde%26utm_id%3Dga_655-575-7282_10556503644_105748314378_448627240777%26vendor_id%3Dga%26account_id%3D655-575-7282%26ad_mt%3D%26ad_mo%3Dmobile%26ad_pm%3Dwww.theguardian.com%26ad_pos%3Dnone%26campaign_id%3D10556503644%26adgroup_id%3D105748314378%26ad_id%3D448627240777%26click_id%3D%7Bgclid%7D%26ad_kw%3D%26ad_nw%3Dd%26ad_dev%3Dm%26ad_devmod%3Dapple%252Biphone%26utm_campaign%3D10556503644%26utm_term%3D%26utm_content%3D448627240777",
        "https://www.dianomi.com/smartads.epl?id=4651",
        "https://platform.twitter.com/widgets/widget_iframe.96fd96193cc66c3e11d4c5e4c7c7ec97.html?origin=https%3A%2F%2Fgraphics.thomsonreuters.com",
        "https://imasdk.googleapis.com/js/core/bridge3.416.2_en_gb.html#goog_1018570912",
        "https://s7.addthis.com/static/sh.f48a1a04fe8dbf021b4cda1d.html#rand=0.7766023683085544&iit=1602423520070&tmr=load%3D1602423519912%26core%3D1602423519932%26main%3D1602423520069%26ifr%3D1602423520072&cb=0&cdn=0&md=0&kw=Arizona%2CUnited%20States%2CStephanie%20Keith%2CLiving%20Planet%2CClimate%20Change%2CWater%2CEnvironment%2CEarth%2CNature%2CRain%2CDrought%2CU.S.%20Politics%2CTrump%2CElections&ab=-&dh=widerimage.reuters.com&dr=&du=https%3A%2F%2Fwiderimage.reuters.com%2Fstory%2Fclimate-change-is-drying-the-lifeblood-of-navajo-ranchers-as-their-lands-become-desert%3Futm_campaign%3Dweb-app-launch%26utm_medium%3Dbanner%26utm_source%3Drcom%26utm_content%3Dros&href=https%3A%2F%2Fwiderimage.reuters.com%2Fstory%2Fclimate-change-is-drying-the-lifeblood-of-navajo-ranchers-as-their-lands-become-desert&dt=Climate%20change%20is%20drying%20the%20lifeblood%20of%20Navajo%20ranchers%20as%20their%20lands%20become%20desert&dbg=0&cap=tc%3D0%26ab%3D0&inst=1&jsl=131073&prod=undefined&lng=en&ogt=locality%2Cdescription%2Cheight%2Cwidth%2Cimage%2Ctitle%2Ctype%3Darticle&pc=men&pub=ra-54e32b736b5ad1fe&ssl=1&sid=5f830adfaa5c76b3&srf=0.01&ver=300&xck=0&xtr=0&og=site_name%3DThe%2520Wider%2520Image%26url%3Dhttps%253A%252F%252Fwiderimage.reuters.com%252Fstory%252Fclimate-change-is-drying-the-lifeblood-of-navajo-ranchers-as-their-lands-become-desert%26type%3Darticle%26title%3DClimate%2520change%2520is%2520drying%2520the%2520lifeblood%2520of%2520Navajo%2520ranchers%2520as%2520their%2520lands%2520become%2520desert%26image%3Dhttps%253A%252F%252Fphotos.wi.gcs.trstatic.net%252FWBTnOVC7qqta06gXHeKsQ3ZxuCfZIeTKXD8EoWVvw-ZPwxZjmpgR3xpmatdKPO1Er1DxMAMuzV-pFFsihtnzico8ZcMeCfsV0hURQJZtKgKDwqgZAaRA8eh6xWipOXCY%26width%3D768%26height%3D512%26description%3DTwo%2520decades%2520into%2520a%2520severe%2520drought%2520on%2520the%2520Navajo%2520reservation%252C%2520the%2520open%2520range%2520around%2520Maybelle%2520Sloan%25E2%2580%2599s%2520sheep%2520farm%2520stretches%2520out%2520in%2520a%2520brown%2520expanse%2520of%2520earth%2520and%2520sagebrush.%26locality%3DArizona&csi=undefined&rev=v8.28.7-wp&ct=0&xld=1&xd=1",
        "https://www-spiegel-de.cdn.ampproject.org/v/s/www.spiegel.de/wirtschaft/unternehmen/donald-trump-beschaedigt-auch-unsere-demokratie-kolumne-a-71714efc-dde0-44e3-9262-52bfda6956d6-amp?amp_js_v=0.1&usqp=mq331AQHKAFQArABIA%3D%3D#origin=https%3A%2F%2Fwww.google.com&prerenderSize=1&visibilityState=prerender&paddingTop=32&p2r=0&csi=1&aoh=16024236043244&viewerUrl=https%3A%2F%2Fwww.google.com%2Famp%2Fs%2Fwww.spiegel.de%2Fwirtschaft%2Funternehmen%2Fdonald-trump-beschaedigt-auch-unsere-demokratie-kolumne-a-71714efc-dde0-44e3-9262-52bfda6956d6-amp&history=1&storage=1&cid=1&cap=navigateTo%2Ccid%2CfullReplaceHistory%2Cfragment%2CreplaceUrl%2Cswipe%2CiframeScroll",
        "https://static.emsservice.de/werbemittel/ejp/Eurojackpot_1577722552/EJP_19-11_SPON-Ads_Responsive-Billboard/index.html",
        "https://aax-eu.amazon-adsystem.com/s/iu3?cm3ppd=1&d=dtb-pub&csif=t&dl=n-emx&dcc=t",
        "https://secure-assets.rubiconproject.com/utils/xapi/multi-sync.html?p=19564_2&endpoint=us-east&gdpr=1&gdpr_consent=CO7Hn9TO7HoCpASABCENA6CsAP_AAG_AAAYgGxwIAAAgAKgAYABoAEgAOQAgACEAGgAOgAfABFgCYAJoATwApABbAC_AGEAYgAzAB4AD8AIAAQkAjgCPgFIAUoArYCDgIQARYAtABgAEMAI1AXmAwQDY4CQAHIAQABCADQAHwATAAngBSAC-AGIAMwAhABHAClgIOAhABFgC0AGAAXmAAA.YAAAAAAAAAAA",
        "https://eus.rubiconproject.com/usync.html?p=19564_2&endpoint=us-east&gdpr=1&gdpr_consent=CO7Hn9TO7HoCpASABCENA6CsAP_AAG_AAAYgGxwIAAAgAKgAYABoAEgAOQAgACEAGgAOgAfABFgCYAJoATwApABbAC_AGEAYgAzAB4AD8AIAAQkAjgCPgFIAUoArYCDgIQARYAtABgAEMAI1AXmAwQDY4CQAHIAQABCADQAHwATAAngBSAC-AGIAMwAhABHAClgIOAhABFgC0AGAAXmAAA.YAAAAAAAAAAA",
        "https://ams.creativecdn.com/tags?type=iframe&id=pr_xhTnXtOx50jOnWfwIwkY_home&tc=1",
        "https://a3013110282.cdn.optimizely.com/client_storage/a3013110282.html"
    ]
    
    override func setUp() {
        tron = .init()
    }
    
    func test() {
        let expect = expectation(description: "")
        expect.expectedFulfillmentCount = list.count
        list.forEach { string in
            tron.accept(URL(string: string)!) {
                XCTAssertFalse($0, string)
                XCTAssertEqual(.main, Thread.current)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 1)
    }
}
