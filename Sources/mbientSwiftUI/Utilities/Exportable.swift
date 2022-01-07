// Copyright 2022 MbientLab Inc. All rights reserved. See LICENSE.MD.

import SwiftUI
import UniformTypeIdentifiers

protocol ExporterVM: AnyObject {
    associatedtype Export: Exportable
    var export: Export? { get }
    func dismissExportPopover()
}

protocol Exportable: Identifiable, FileDocument {
    var name: String { get }
}

extension ExporterVM {

    func presentExporter(for id: Export.ID) -> Binding<Bool> {
        .init(
            get: { [weak self] in self?.export?.id == id },
            set: { [weak self] newValue in
                if newValue == false { self?.dismissExportPopover() }
            }
        )
    }
}

extension View {

    func exportDocument<VM: ExporterVM>(
        id: VM.Export.ID,
        vm: VM,
        onCompletion: @escaping (Result<URL,Error>) -> Void = { _ in }
    ) -> some View {
        self.fileExporter(
            isPresented: vm.presentExporter(for: id),
            document: vm.export,
            contentType: VM.Export.readableContentTypes.first!,
            defaultFilename: vm.export?.name,
            onCompletion: onCompletion)
    }
}


// MARK: - Conforming Types

struct Folder: FileDocument, Exportable {
    static var readableContentTypes = [UTType.folder]
    let wrapper: FileWrapper
    var id: UUID
    var name: String

    init(url: URL, id: UUID, name: String) throws {
        self.id = id
        self.name = name
        self.wrapper = try FileWrapper(url: url, options: [])
        guard wrapper.isDirectory else { throw CocoaError(.featureUnsupported) }
    }

    init(configuration: ReadConfiguration) throws {
        self.wrapper = configuration.file
        self.id = .init()
        self.name = ""
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        wrapper
    }
}

// MARK: - Example client

//    func prepareExportable(onQueue: DispatchQueue,
//                           didComplete: @escaping (Result<Folder,Error>) -> Void) {
//        onQueue.async { [weak self] in
//            guard let self = self else { return }
//            do {
//                let folder = try Folder(url: self.tempDirectoryURL,
//                                        id: self.id,
//                                        name: self.name)
//                DispatchQueue.main.async {
//                    didComplete(.success(folder))
//                }
//
//            } catch {
//                DispatchQueue.main.async {
//                    didComplete(.failure(error))
//                }
//            }
//        }
//    }
