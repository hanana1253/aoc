let puzzleInput =
  Node.Fs.readFileAsUtf8Sync("input/Week1/Year2020Day5.puzzleInput.txt")->Js.String2.split("\n")

// puzzleInput->Js.log
// TODO:
// 1. "F", "L"이면 Zero, "B", "R"이면 One 타입으로 만들어준다.
// 2. input을 위의 타입의 array로 바꿔주고 상응하는 int로 파싱해준다.
// 3. array를 순회하며 기존 acc 값에 2를 곱한 값에다가 현재의 요소가 Zero인 경우 0, One인 경우 2를 더해준다.
open Belt

type binary = Zero | One

let parseString = seatString =>
  switch seatString {
  | "F" | "L" => Zero
  | "B" | "R" | _ => One
  }

let convertToNum = parsedSeatString =>
  switch parsedSeatString {
  | Zero => 0
  | One => 1
  }

let getDecimal = array => array->Array.reduce(0, (acc, cur) => acc * 2 + cur)

let getSeatNumber = seat =>
  seat->Js.String2.split("")->Array.map(char => char->parseString->convertToNum)->getDecimal

puzzleInput->Array.map(getSeatNumber)->Js.Math.maxMany_int->Js.log
