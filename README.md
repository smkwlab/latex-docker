# Docker image for textlint

## Usage

カレントディレクトリに textlint でチェックしたいファイルを置いてください。
あとは VScode 上で、そのファイルを編集して保存します。
VScode の「問題」ウィンドウに textlint の結果が表示されます。

## Author

toshi0806 : Toshihiko SHIMOKAWA // toshi@smkwlab.net

## License

MIT

## Pull Image

```bash
docker pull ghcr.io/smkwlab/textlint-docker:latest
```

## About 

* このイメージは https://github.com/being24/latex-docker を基にしていますが、
LaTeX に関するアプリケーションはインストールされていません。
* このイメージは以下の目的で利用するために作成されました。
  * 下川研究室で利用するための ghcr.io/smkwlab/latex-docker のベース
  * LaTeX とは独立の HTML や MarkDown 文章の textlint 環境
* このブランチは master ブランチには merge せずにメンテナンスすることを意図しています。
