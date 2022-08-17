let puzzleInput =
  Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day5.puzzleInput.txt")->Js.String2.split("\n")

// puzzleInput->Js.log
// TODO:
// 1. binary search 값을 알아내는 함수를 만든다
// 1-1. string을 인덱스 6 이전과 7 이후로 나눈다
// 1-2. F/L를 0으로, B/R를 1로 해서 2의 length-index+1승만큼 더하게 한다. -> 문자열을 0, 1로 치환해준 후 parseInt
// 2. row와 column 값을 알아낸다
// 3. seat ID를 알아낸다
// 4. 가장 높은 값을 추려낸다

@scope("Number") @val
external parseInt: (string, int) => int = "parseInt"

// 1-1. string을 인덱스 6 이전과 7 이후로 나누기
let splitByIndex = (string, index) => [
  string->Js.String2.slice(~from=0, ~to_=index),
  string->Js.String2.sliceToEnd(~from=index),
]

// 1-2. binary 값을 각각 알아내기

open Belt
let getDecimalFromBinaryWithArray = string => {
  string
  ->Js.String2.split("")
  ->Array.map(char => ["F", "L"]->Js.Array2.includes(char) ? "0" : "1")
  ->Js.Array2.joinWith("")
  ->parseInt(2)
}

let getDecimalFromBinaryWithStringReplacement = string => {
  string
  ->Js.String2.unsafeReplaceBy0(%re("/([FL])|([BR])/g"), (match, _, _) =>
    match == "F" || match == "L" ? "0" : "1"
  )
  ->parseInt(2)
}

let getSeatId = ([row, column]) => row * 8 + column

puzzleInput
->Array.map(boardingPass =>
  boardingPass->splitByIndex(7)->Array.map(getDecimalFromBinaryWithArray)->getSeatId
)
->Js.Math.maxMany_int
->Js.log
