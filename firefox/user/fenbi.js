// ==UserScript==
// @name         fenbi_no_lazy_load_images
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://www.fenbi.com/*
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @grant        none
// ==/UserScript==
const arr = ['data-src'];
const obj = {};
arr.forEach((item) => {
  obj[item] = true;
})

function noLazyNode(node) {
    any(node.attributes, function(attr) {
        if (attr.name in obj) {
            var newSrc = attr.value;
            if (node.src != newSrc) {
                 console.log('%s 被替换为 %s', node.src, newSrc);
                node.src = newSrc;
            }
            return true;
        }
    });
}

function any(c, fn) {
    return Object.keys(c).some(function(k) {
        return fn(c[k]);
    });
}

function map(c, fn) {
    return Object.keys(c).map(function(k) {
        return fn(c[k]);
    });
}

function addMutationObserver(selector, callback) {
    var watch = document.querySelector(selector);
    if (!watch) return;

    var observer = new MutationObserver(function(mutations){
        mutations.forEach(function(m) {
            map(m.addedNodes, function(node) {
                if (node.nodeType == Node.ELEMENT_NODE) {
                    callback(node);
                }
            });
        });
    });
    observer.observe(watch, {childList: true, subtree: true});
}

function run() {
    addMutationObserver('body', function(parent) {
        var images = parent.querySelectorAll('img');
        if (images) {
        	map(images, noLazyNode);
        }
    });
}

run();
