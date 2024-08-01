import { computed, defineComponent, onMounted, onUnmounted, ref } from "vue";
import "../style.scss";

import { MapManager } from './mapManager';

export default defineComponent({
    setup() {
        const mapManager = new MapManager(null, null);
        const isWeb = computed(() => getPlatform() == 'Web');
        const getPlatform = () => {
            let platform = navigator.userAgent || navigator.platform;
            if (/iPad|iPhone|iPod/i.test(platform) && !(window as any).MSStream) {
                return 'iOS';
            } else if (/android/i.test(platform)) {
                return 'Android';
            } else if (/chrome|edg/i.test(platform)) {
                return 'Web';
            } else if (/Mac|iPod|iPad|iPhone/i.test(platform)) {
                return 'Mac'; // iOS 在 Safari 中会同时检测到 Mac 和 iOS，因此要先于 iOS 判断
            } else if (/linux/i.test(platform)) {
                return 'Linux';
            } else if (/nix/i.test(platform)) {
                return 'Unix';
            } else if (/win/i.test(platform)) {
                return 'Windows';
            }
        }
        onMounted(() => {
            //mapManager.Init(null);
            listener();
        });
        const listener = () => {
            isWeb.value ? window.parent.addEventListener("message", getFlutterMessage_web,) :
                window.addEventListener("flutterInAppWebViewPlatformReady", getFlutterMessage_app);
        }
        const removeListener = () => {
            // 移除信息监听
            isWeb.value ? window.parent.removeEventListener("message", getFlutterMessage_web) :
                window.removeEventListener("flutterInAppWebViewPlatformReady", getFlutterMessage_app);
        }
        onUnmounted(() => {
            removeListener();
        });
        const getFlutterMessage_app = () => {
            (window as any).getFlutterMessage_app = (data: any) => {
                handlerMessage(data);
            }
        }
        const getFlutterMessage_web = (event: MessageEvent<any>) => {
            if (typeof event.data === "string") {
                var data = JSON.parse(event.data);
                // 只响应 Flutter 发出来的信息 (过滤掉地图发送的信息)
                if (typeof data == "object" && 'flutter' in data) {
                    var obj = data.flutter;
                    console.log('Flutter 发送到map的信息： ' + obj);

                    handlerMessage(obj);
                }
            }
        }
        /** 处理从flutter发送过来的数据 */
        const handlerMessage = (obj: any) => {
            console.log('obj', typeof obj, obj);
            const data = JSON.parse(obj);
            if ('fn' in data) {
                if ('MapMessageFN.Locate' == data.fn) {
                    
                    mapManager.locateTest(data.data);
                }
                else if ('MapMessageFN.MapInfo' == data.fn) {
                    
                    mapManager.Init(data.data);
                }
                else if ('MapMessageFN.UpdateDefects' == data.fn) {
                    
                    mapManager.UpdateDefects(data.data);
                }
                else if ('MapMessageFN.Capture' == data.fn) {
                    
                    mapManager.Capture();
                }
                else if ('MapMessageFN.ZoomIn' == data.fn) {
                    
                    mapManager.zoomMap(0);
                }
                else if ('MapMessageFN.ZoomOut' == data.fn) {
                    
                    mapManager.zoomMap(1);
                }
            }
        }
        const postFlutterMessage = (data: any) => {
            if (isWeb.value) {
                window.parent.postMessage(JSON.stringify(data), window.location.origin);
            } else {
                try {
                    (window as any).flutter_inappwebview
                        .callHandler('handlerMessage', JSON.stringify(data))
                } catch (error) {
                    console.log('error： ' + error);
                }
            }
        }
        const send = () => {
            postFlutterMessage({ ccc: 11111 });
        }
        return {
            postFlutterMessage, send,
        }

    },
    render() {
        return <>
            <button onClick={this.send}>发送WEBView信息</button>
            <div id="map" ></div>
            <a id="image-download" download="map.png"></a>
        </>
    }
});
