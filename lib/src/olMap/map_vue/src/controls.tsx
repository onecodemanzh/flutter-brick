import { Control, ScaleLine, defaults as defaultControls, MousePosition } from 'ol/control';

export class myZoominControl extends Control {
    /**
     * @param {Object} [opt_options] Control options.
     */// @ts-ignore
    constructor(opt_options: any = {}) {
        const options = opt_options;

        const button = document.createElement('button');
        button.style.backgroundColor = 'rgba(0,0,0,0)';
        if (!button.classList.contains('map-zoomin-btn')) {
            button.classList.add('map-zoomin-btn');
        }
        button.style.backgroundSize = "44px 44px";
        button.style.width = '44px';
        button.style.height = '44px';
        button.style.border = 'none';

        const element = document.createElement('div');
        element.className = 'myZoomin';
        element.appendChild(button);

        super({
            element: element,
            target: options.target

        });

        button.addEventListener('click', this.handleClick.bind(this), false);
    }

    handleClick() {
        // @ts-ignore
        const view = this.getMap().getView();
        const zoom = view.getZoom();
        // @ts-ignore
        view.setZoom(zoom + 1);
    }
}

export class myZoomoutControl extends Control {
    /**
     * @param {Object} [opt_options] Control options.
     */
    // @ts-ignore
    constructor(opt_options: any = {}) {
        const options = opt_options;

        const button = document.createElement('button');
        button.style.backgroundColor = 'rgba(0,0,0,0)';
        if (!button.classList.contains('map-zoomout-btn')) {
            button.classList.add('map-zoomout-btn');
        }
        button.style.backgroundSize = "44px 44px";
        button.style.width = '44px';
        button.style.height = '44px';
        button.style.border = 'none';

        const element = document.createElement('div');
        element.className = 'myZoomout';
        element.appendChild(button);

        super({
            element: element,
            target: options.target

        });

        button.addEventListener('click', this.handleClick.bind(this), false);
    }

    handleClick() {
        // @ts-ignore
        const view = this.getMap().getView();
        const zoom = view.getZoom();

        // @ts-ignore
        view.setZoom(zoom - 1);
    }
}

export class myFilterControl extends Control {
    /**
     * @param {Object} [opt_options] Control options.
     */
    constructor(
        private emit: (event: "filter", ...args: any[]) => void,
        private c: any,
        opt_options: any = {}
    ) {
        const options = opt_options;
        const button = document.createElement('button');
        button.style.backgroundColor = 'rgba(0,0,0,0)';
        if (!button.classList.contains('map-filter-btn')) {
            button.classList.add('map-filter-btn');
        }
        button.style.backgroundSize = "44px 44px";
        button.style.width = '44px';
        button.style.height = '44px';
        button.style.border = 'none';

        const element = document.createElement('div');
        element.className = 'myFilter';
        element.appendChild(button);

        super({
            element: element,
            target: options.target
        });

        button.addEventListener('click', this.handleClick.bind(this), false);
    }

    handleClick() {
        this.emit('filter', this.c);
    }
}

export class myOpenControl extends Control {
    /**
     * @param {Object} [opt_options] Control options.
     */
    // @ts-ignore
    constructor(opt_options: any = {}) {
        const options = opt_options;

        const button = document.createElement('button');
        button.style.backgroundColor = 'rgba(0,0,0,0)';
        if (!button.classList.contains('map-open-btn')) {
            button.classList.add('map-open-btn');
        }
        button.style.backgroundSize = "44px 44px";
        button.style.width = '44px';
        button.style.height = '44px';
        button.style.border = 'none';

        const element = document.createElement('div');
        element.className = 'myOpen';
        element.appendChild(button);

        super({
            element: element,
            target: options.target
        });

        button.addEventListener('click', this.handleClick.bind(this), false);
    }

    handleClick() {
        // @ts-ignore

        let ctrls = this.getMap().getControls().getArray();
        for (let i = 0; i < ctrls.length; i++) {
            let div: HTMLDivElement = (ctrls[i] as any).element as HTMLDivElement;
            // if (ctrls[i].constructor.name == "LayerSwitcher" || ctrls[i].constructor.name == "X") {
            if (div.classList.contains('layer-switcher')) {
                // @ts-ignore
                if (ctrls[i].element.style.display == 'none') {
                    // @ts-ignore
                    ctrls[i].element.style.display = 'inline';
                    let button = this.element.getElementsByTagName('button');
                    if (!button[0].classList.contains('map-close-btn')) {
                        button[0].classList.add('map-close-btn');
                    }
                } else {
                    // @ts-ignore
                    ctrls[i].element.style.display = 'none';
                    let button = this.element.getElementsByTagName('button');
                    if (!button[0].classList.contains('map-open-btn')) {
                        button[0].classList.add('map-open-btn');
                    }
                }
            }
            if (ctrls[i].constructor.name == "myFilterControl") {
                // @ts-ignore
                if (ctrls[i].element.style.display == 'none') {
                    // @ts-ignore
                    ctrls[i].element.style.display = 'inline';
                }
                else {// @ts-ignore
                    ctrls[i].element.style.display = 'none';
                }
            }
        }
    }

}

export class CoordinatesControl extends Control {
    /**
     * @param {Object} [opt_options] Control options.
     */
    constructor(_map: any, opt_options: any = {}) {
        const options = opt_options || {};
        const element = document.createElement('div');

        let currMouseEventParam: any;

        const divX = document.createElement('div');
        divX.innerText = `X:`;
        divX.style.paddingRight = '10px';
        divX.style.display = 'inline';

        const divY = document.createElement('div');
        divY.innerText = `Y:`;
        divY.style.paddingRight = '10px';
        divY.style.display = 'inline';

        const divScale = document.createElement('div');
        divScale.style.display = 'inline';
        divScale.style.paddingLeft = '95px';

        element.className = 'myCooridnates';
        element.appendChild(divX);
        element.appendChild(divY);
        element.appendChild(divScale);

        let scaleLine: any;
        let ctrls = _map.getControls().getArray();
        for (let i = 0; i < ctrls.length; i++) {
            if (ctrls[i].element.className.indexOf('scale') > -1) // @ts-ignore
            {
                scaleLine = ctrls[i];

                break;
            }
        }

        setScaleLabel();

        function setScaleLabel() {
            divScale.innerHTML = scaleLine.element.innerText == '1000 m' ? '1 km' : scaleLine.element.innerText;
        }

        scaleLine.element.addEventListener('DOMNodeInserted', function (evt: any) {
            setScaleLabel();
        })

        _map.on('click', function (evt: any) {
            currMouseEventParam = evt;
            divScale.style.paddingLeft = '0px';
            divX.innerHTML = 'X:' + evt.coordinate[0].toFixed(1);
            divY.innerHTML = 'Y:' + evt.coordinate[1].toFixed(1);

            //setScaleLabel();
        }),
            _map.on('pointermove', function (evt: any) {
                currMouseEventParam = evt;
                divScale.style.paddingLeft = '0px';
                divX.innerHTML = 'X:' + evt.coordinate[0].toFixed(1);
                divY.innerHTML = 'Y:' + evt.coordinate[1].toFixed(1);

                //setScaleLabel();
            }),
            super({
                element: element,
                target: options.target
            });
    }
}

export class myExportPhotoControl extends Control {
    /**
     * @param {Object} [opt_options] Control options.
     */// @ts-ignore
    constructor(private _map: any, opt_options: any = {}) {
        const options = opt_options;

        const button = document.createElement('button');
        button.style.backgroundColor = 'rgba(0,0,0,0)';
        if (!button.classList.contains('map_print_btn')) {
            button.classList.add('map_print_btn');
        }
        button.style.backgroundSize = "44px 44px";
        button.style.width = '44px';
        button.style.height = '44px';
        button.style.border = 'none';

        const element = document.createElement('div');
        element.className = 'myExportPhoto';
        element.appendChild(button);

        let map: any = _map?.p?.option;
        if (!map?.showCurrViewDefectsControl) {
            element.style.top = '144px'
        }

        super({
            element: element,
            target: options.target

        });

        button.addEventListener('click', this.handleClick.bind(this), false);
    }

    handleClick() {
        this._map.exportPhoto();
    }
}

export class CurrViewDefectsControl extends Control {
    /**
     * @param {Object} [opt_options] Control options.
     */// @ts-ignore
    constructor(
        private emit: (event: "doubleFilter", ...args: any[]) => void,
        private _map: any, opt_options: any = {}) {
        const options = opt_options;

        const button = document.createElement('button');
        button.style.backgroundColor = 'rgba(0,0,0,0)';
        if (!button.classList.contains('btn-double-filter')) {
            button.classList.add('btn-double-filter');
        }
        button.innerHTML = `
        <span class=" " title="">
            <svg class="icon" aria-hidden="true"><use xlink:href="#icon-filter"></use></svg>
        </span>
        `
        // button.style.backgroundSize = "44px 44px";
        button.style.width = '44px';
        button.style.height = '44px';
        button.style.border = 'none';

        const element = document.createElement('div');
        element.className = 'CurrViewDefects';
        element.appendChild(button);

        super({
            element: element,
            target: options.target

        });

        button.addEventListener('click', this.handleClick.bind(this), false);
    }

    handleClick() {
        let DefectIdShow = this._map.getcurViewDefectIdShow();
        this.emit('doubleFilter', DefectIdShow)
    }
}

export const getCoordinate = (x: string) => {
    if (x == undefined || x == null)
        return 0;

    let pntX = parseFloat(x);
    if (isNaN(pntX))
        return 0;

    return pntX;
}