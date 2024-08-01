import { computed, defineComponent, onMounted, onUnmounted, ref } from "vue";
import * as THREE from 'three';
import { GLTFLoader, OrbitControls } from "three/examples/jsm/Addons.js";
import GUI from "three/examples/jsm/libs/lil-gui.module.min.js";

import './bim.css';

export default defineComponent({
    setup(props, ctx) {
        const renderer = new THREE.WebGLRenderer({
            antialias: true, // 抗锯齿
            alpha: true
        });
        const scene = new THREE.Scene();

        const camera = ref<THREE.PerspectiveCamera>(new THREE.PerspectiveCamera());
        const src = ref<string>('');
        const div = ref<HTMLDivElement>(document.querySelector('#webgl') as HTMLDivElement);
        const isWeb = computed(() => getPlatform() == 'Web');
        const ambientLight = new THREE.AmbientLight(0xffffff, 1); // 白光，强度为1
        const dirLight = new THREE.DirectionalLight('rgb(253,253,253)', 5);
        const pointLight = new THREE.PointLight('rgb(253,253,253)', 5);


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
        /**
         * 设置Bim
         */
        const setBim = () => {
            // // 创建场景、相机和渲染器
            renderer.setClearColor(0x000, 0);
            const controls = new OrbitControls(camera.value, renderer.domElement);

            controls.addEventListener('change', (e) => {
                renderer.render(scene, camera.value);
            });
            // var str = 'Intergalactic_Spaceships_Version_2.gltf';
            // var str = 'a.gltf';
            // var str = 'modelNew.gltf';
            // var str = 'ufo.gltf';
            // var str = 'a.gltf';
            // var str = 'Wolf-Blender-2.82a.gltf';
            // var str = 'Rigged_Modular UFO 2.8.glb';
            // 加载GLTF模型
            const loader = new GLTFLoader();
            loader.load(src.value, (gltf) => {
                scene.clear();
                
                // console.log('gltf',);
                // 解决模型为黑色的问题
                gltf.scene.traverse(function (child: any) {
                    if (child.isMesh) {
                        child.material.side = THREE.DoubleSide; // 模型双面渲染
                        child.castShadow = true;  // 光照是否有阴影
                        child.receiveShadow = true;  // 是否接收阴影
                        child.frustumCulled = true;
                    }
                });
                scene.add(gltf.scene);
                scene.add(ambientLight);
                scene.add(dirLight);
                scene.add(gltf.scene);
                // 如果模型有动画，播放动画
                if (gltf.animations && gltf.animations.length) {
                    const mixer = new THREE.AnimationMixer(gltf.scene);
                    gltf.animations.forEach((animation) => {
                        const action = mixer.clipAction(animation);
                        action.play();
                    });

                    // 更新动画
                    const animate = () => {
                        requestAnimationFrame(animate);
                        renderer.render(scene, camera.value);
                        if (mixer) {
                            mixer.update(0.01);
                        }
                    };
                    animate();
                }
                renderer.render(scene, camera.value);
            }, undefined, (error) => {
                console.log('error', error);
            });
            // dirLight.position.set(1000, 1000, 60); // 根据需要自行调整位置
            // // 设置相机位置
            camera.value.position.x = .07;
            camera.value.position.y = .16;
            camera.value.position.z = 1.6;
            renderer.setSize(div.value.offsetWidth, div.value.offsetHeight);

            div.value.appendChild(renderer.domElement);
        }
        window.addEventListener('resize', () => {
            renderer.setSize(div.value.offsetWidth, div.value.offsetHeight);
            camera.value.aspect = div.value.offsetWidth / div.value.offsetHeight;
            camera.value.updateProjectionMatrix();
            renderer.render(scene, camera.value);
        });
        onMounted(() => {
            div.value = document.querySelector('#webgl') as HTMLDivElement;
            camera.value = new THREE.PerspectiveCamera(50, div.value.offsetWidth / div.value.offsetHeight, 0.1,
                3000);
            listener();
            if (src.value) setBim();
            setGUI();
        });
        const setGUI = () => {
            const gui = new GUI();
            const ambientLight_group = gui.addFolder('环境光');
            ambientLight_group.addColor(ambientLight, 'color').onChange((value) => {
                ambientLight.color.set(value);
                renderer.render(scene, camera.value);
            }).name(' 颜色');
            ambientLight_group.add(ambientLight, 'intensity', -10, 20).onChange((value) => {
                console.log('环境光 强度:', value);
                renderer.render(scene, camera.value);
            }).name(' 强度');
            ambientLight_group.close();
            const dirLight_group = gui.addFolder('平行光');
            dirLight_group.addColor(dirLight, 'color').onChange((value) => {
                ambientLight.color.set(value);
                renderer.render(scene, camera.value);
            }).name(' 颜色');
            dirLight_group.add(dirLight, 'intensity', -10, 20).onChange((value) => {
                console.log('平行光 强度:', value);
                renderer.render(scene, camera.value);
            }).name(' 强度');
            dirLight_group.close();
            const pointLight_group = gui.addFolder('点光源');
            pointLight_group.addColor(pointLight, 'color').onChange((value) => {
                ambientLight.color.set(value);
                renderer.render(scene, camera.value);
            }).name(' 颜色');
            pointLight_group.add(pointLight, 'intensity', -10, 20).onChange((value) => {
                console.log('点光源 强度:', value);
                renderer.render(scene, camera.value);
            }).name(' 强度');
            pointLight_group.add(pointLight.position, 'x', -1000, 1000).onChange((value) => {
                console.log('点光源 x 坐标:', value);
                renderer.render(scene, camera.value);
            }).name(' x 坐标');
            pointLight_group.add(pointLight.position, 'y', -1000, 1000).onChange((value) => {
                console.log('点光源 y 坐标:', value);
                renderer.render(scene, camera.value);
            }).name(' y 坐标');
            pointLight_group.add(pointLight.position, 'z', -1000, 1000).onChange((value) => {
                console.log('点光源 z 坐标:', value);
                renderer.render(scene, camera.value);
            }).name(' z 坐标');
            pointLight_group.close();
            // const camera_group = gui.addFolder('相机');
            // camera_group.add(camera.value.position, 'x', -1000, 1000).onChange((value) => {
            //     console.log('相机 x 坐标:', value);
            //     renderer.render(scene, camera.value);
            // }).name(' x 坐标');
            // camera_group.add(camera.value.position, 'y', -1000, 1000).onChange((value) => {
            //     console.log('相机 y 坐标:', value);
            //     renderer.render(scene, camera.value);
            // }).name(' y 坐标');
            // camera_group.add(camera.value.position, 'z', -1000, 1000).onChange((value) => {
            //     console.log('相机 z 坐标:', value);
            //     renderer.render(scene, camera.value);
            // }).name(' z 坐标');
            // camera_group.close();
        }
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
                // 只响应 Flutter 发出来的信息 (过滤掉非flutter（自身）发送的信息)
                if (typeof data == "object" && 'flutter' in data) {
                    var obj = data.flutter;
                    handlerMessage(obj);
                }
            }
        }
        /** 处理从flutter发送过来的数据 */
        const handlerMessage = (obj: any) => {
            console.log('Flutter 发送的信息： ' + obj);
            obj = JSON.parse(obj);
            console.log(3, obj);
            console.log(4, obj.src);
            if (obj.src) {
                src.value = obj.src;
                setBim();
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
        return {
            postFlutterMessage,
        }
    },
    render() {
        return <div id="webgl"></div>
    }
});