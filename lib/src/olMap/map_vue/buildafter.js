import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

// 获取当前模块的目录路径
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// 定义源文件夹和目标文件夹路径
const sourceFolder = path.join(__dirname, 'dist');
const destinationFolder = path.join(__dirname, '..', '..', '..', '..', '..', 'assets', 'map');

// 确保目标文件夹存在（如果不存在则创建它）
function ensureFolder(folderPath, callback) {
    if (!fs.existsSync(folderPath)) {
        fs.mkdir(folderPath, { recursive: true }, (err) => {
            if (err) {
                console.error('创建文件夹时出错:', err);
                return;
            }
            callback();
        });
    } else {
        callback();
    }
}

// 删除目标文件夹及其内容
function deleteFolderRecursive(folderPath, callback) {
    if (fs.existsSync(folderPath)) {
        fs.rm(folderPath, { recursive: true, force: true }, (err) => {
            if (err) {
                console.error('删除文件夹时出错:', err);
                return;
            }
            // 再次确保目标文件夹存在
            ensureFolder(folderPath, callback);
        });
    } else {
        // 如果文件夹不存在，直接创建它
        ensureFolder(folderPath, callback);
    }
}


// 递归复制文件夹及其内容
function copyFolderRecursive(source, destination, callback) {
    fs.readdir(source, (err, items) => {
        if (err) {
            console.error('读取源文件夹时出错:', err);
            return;
        }

        let pending = items.length;

        if (pending === 0) {
            // 如果没有待处理的文件和文件夹，则调用回调
            callback();
        }

        items.forEach(item => {
            const sourcePath = path.join(source, item);
            const destinationPath = path.join(destination, item);

            fs.stat(sourcePath, (err, stats) => {
                if (err) {
                    console.error(`获取 ${sourcePath} 状态时出错:`, err);
                    return;
                }

                if (stats.isDirectory()) {
                    // 如果是目录，则递归复制
                    fs.mkdir(destinationPath, { recursive: true }, (err) => {
                        if (err) {
                            console.error(`创建目录 ${destinationPath} 时出错:`, err);
                        } else {
                            copyFolderRecursive(sourcePath, destinationPath, () => {
                                // 递归完成后检查是否所有操作完成
                                if (--pending === 0) {
                                    callback();
                                }
                            });
                        }
                    });
                } else {
                    // 如果是文件，则复制文件
                    fs.copyFile(sourcePath, destinationPath, err => {
                        if (err) {
                            console.error(`复制文件 ${sourcePath} 到 ${destinationPath} 时出错:`, err);
                        }
                        // 文件复制完成后检查是否所有操作完成
                        if (--pending === 0) {
                            callback();
                        }
                    });
                }
            });
        });
    });
}

// 删除目标文件夹并重新创建
deleteFolderRecursive(destinationFolder, () => {
    copyFolderRecursive(sourceFolder, destinationFolder, () => {
        console.log('复制成功!');
    });
});