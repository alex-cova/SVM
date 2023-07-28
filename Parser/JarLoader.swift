//
//  JarLoader.swift
//  SVM
//
//  Created by Alex on 28/07/23.
//

import Foundation
import Zip


class JarLoader : ObservableObject {
    
    var entries : [ClassEntry] = []
    var files : [URL]?
    var jarFile : URL?
    var jarName = ""
    
    init() {
        Zip.addCustomFileExtension("jar")
    }
    
    public func load(url : URL) -> Bool {
        
        if jarFile == url {
            return true
        }
        
        self.jarFile = url
        self.jarName = url.lastPathComponent
        
        do {
            let parentUrl = try Zip.quickUnzipFile(url)
            
            print(parentUrl)
            
            guard let files = listAllFilesInFolder(at: parentUrl) else {
                return false
            }
            
            
            print("Loaded \(files.count) files in jar")
            
            for f in files {
                entries.append(ClassEntry(f, parentUrl))
            }
            
            self.files = files
            
        }catch {
            print(error)
            
            return false
        }
        
        return true
    }
    
    
    func listAllFilesInFolder(at folderURL: URL) -> [URL]? {
        do {
            let fileManager = FileManager.default
            let fileURLs = try fileManager.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
            var allFiles: [URL] = []

            for fileURL in fileURLs {
                var isDirectory: ObjCBool = false
                if fileManager.fileExists(atPath: fileURL.path, isDirectory: &isDirectory) {
                    if isDirectory.boolValue {
                        if let subFiles = listAllFilesInFolder(at: fileURL) {
                            allFiles.append(contentsOf: subFiles)
                        }
                    } else {
                        allFiles.append(fileURL)
                    }
                }
            }

            return allFiles
        } catch {
            print("Error listing files in folder: \(error.localizedDescription)")
            return nil
        }
    }
    
}

