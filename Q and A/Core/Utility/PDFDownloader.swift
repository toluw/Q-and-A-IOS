//
//  PDFDownloader.swift
//  Q and A
//
//  Created by GIGL-PC on 08/07/2026.
//

import Foundation

protocol PDFDownloaderDelegate: AnyObject {

    func progress(_ progress: Double)

    func finished(localURL: URL)

    func failed(error: Error)

}



final class PDFDownloader: NSObject {

    weak var delegate: PDFDownloaderDelegate?

    private var destinationURL: URL!

    func download(
        from remoteURL: URL,
        destination: URL
    ) {

        self.destinationURL = destination

        let session = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: .main
        )

        session.downloadTask(with: remoteURL).resume()
    }

}


extension PDFDownloader: URLSessionDownloadDelegate {

    func urlSession(
        _ session: URLSession,
        downloadTask: URLSessionDownloadTask,
        didWriteData bytesWritten: Int64,
        totalBytesWritten: Int64,
        totalBytesExpectedToWrite: Int64
    ) {

        delegate?.progress(
            Double(totalBytesWritten)
            / Double(totalBytesExpectedToWrite)
        )

    }

    func urlSession(
        _ session: URLSession,
        downloadTask: URLSessionDownloadTask,
        didFinishDownloadingTo location: URL
    ) {

        do {

            try? FileManager.default.removeItem(at: destinationURL)

            try FileManager.default.moveItem(
                at: location,
                to: destinationURL
            )

            delegate?.finished(localURL: destinationURL)

        } catch {

            delegate?.failed(error: error)

        }

    }

}
