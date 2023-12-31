# SwiftUI_CalendarApp

SwiftUI のカレンダーアプリ

カレンダーアプリの作成を通し、ToDo リストアプリから発展したデータ構造の SwiftUI の学習を行う。

## アプリ概要

- カレンダーアプリ
- 各日付に日記を記録できる

![アプリ カレンダー画面](/Pictures/calendarView.png)

![アプリ 日記入力画面](/Pictures/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202023-11-24%20at%2019.06.43.png)

### 学習したいこと

- SwiftData
- データ構造について
- データの保存・削除・更新についての理解を深める。

## 構成

1. SwiftData を利用したプロジェクトファイルの作成
2. 作成したプロジェクトファイルの確認
   - SwiftData のプロジェクトテンプレートに触れる
3. SwiftData について
   - データ構造の作成
   - 書き方について
   - データの保存・削除・更新 (CRUD)
   - iOS17 からのリリースである説明
   - SwiftData を使うメリット
     - データの永続化
     - SwiftUI との親和性
4. カレンダーの表示を追加
5. カレンダーの日付をタップした時に表示する Todo を絞り込む
6. カレンダー用にデータ構造を変更する
7. データ構造に合わせて表示の UI を変更する
8. データの削除機能を追加
   - `onDelete` を利用する
   - `onDelete` は `ForEach` で利用する
   - delete の処理は `SwiftData` の `delete` を利用する (挑戦問題)
9. データの更新機能を追加
10. 日記入力画面の UI を洗練させる（挑戦問題）

## Swift Packege Manager

- なし

## Framework

- SwiftaData
