" Vim syntax file
" Language: Flat
" Author: Braden Steffaniak <BradenSteffaniak@gmail.com>
" URL: https://github.com/FlatLang/vim-flat

if exists("b:current_syntax")
  finish
endif

let b:current_syntax = "flat"

" Syntax {{{1
syn sync fromstart

" Miscellaneous (low priority) {{{2
syn keyword flatKeywordError contained
      \ package abstract as break case catch class continue default
      \ else enum external false finally for if in interface trait null override
      \ private visible public return static switch this throw true try
      \ import while

syn match flatDelimiter /\%#=1,/ containedin=@flatExtras
syn match flatDelimiter /\%#=1\n/ containedin=@flatBlocks

syn region flatBlock matchgroup=flatDelimiter start=/\%#=1{/ end=/\%#=1}/ contains=TOP fold

" LHS {{{2
syn keyword flatStatement global alias

syn keyword flatStatement class struct interface nextgroup=flatTypeName skipwhite
syn match flatTypeName /\%#=1\K\k*\%(<.\{-}>\)\=/ contained contains=flatKeywordError,flatGenericParameters nextgroup=flatTypeBlock,flatTypeInheritanceOperator,flatTypeConstraint skipwhite
syn match flatTypeName /\%#=1@\K\k*\%(<.\{-}>\)\=/ contained contains=flatGenericParameters nextgroup=flatTypeBlock,flatTypeInheritanceOperator skipwhite
syn region flatGenericParameters matchgroup=flatDelimiter start=/\%#=1</ end=/\%#=1>/ contained oneline contains=flatGenericParameter,flatModifier nextgroup=flatTypeBlock skipwhite
syn match flatGenericParameter /\%#=1\K\k*/ contained contains=flatKeywordError
syn match flatGenericParameter /\%#=1@\K\k*/ contained
syn match flatTypeInheritanceOperator /\%#=1:/ contained nextgroup=flatTypeInheritee,flatTypeInheriteeKeyword skipwhite
syn match flatTypeInheritee /\%#=1\K\k*\%(<.\{-}>\)\=/ contained contains=flatKeywordError,flatGeneric nextgroup=flatTypeBlock,flatTypeInheriteeMemberAccessOperator,flatTypeInheriteeComma,flatTypeConstraint,flatTypeInheriteeArguments,flatTypeConstraintModifier skipwhite
syn match flatTypeInheritee /\%#=1@\K\k*\%(<.\{-}>\)\=/ contained contains=flatGeneric nextgroup=flatTypeBlock,flatTypeInheriteeMemberAccessOperator,flatTypeInheriteeComma,flatTypeConstraint,flatTypeInheriteeArguments,flatTypeConstraintModifier skipwhite
syn keyword flatTypeInheriteeKeyword contained nextgroup=flatTypeBlock,flatTypeInheriteeComma,flatTypeConstraint,flatTypeConstraintModifier skipwhite
      \ class enum default
syn match flatTypeConstraintModifier /\%#=1?/ contained nextgroup=flatTypeInheriteeMemberAccessOperator,flatTypeInheriteeComma,flatTypeConstraint skipwhite
syn keyword flatTypeInheriteeKeyword new contained nextgroup=flatTypeInheriteeArguments,flatTypeInheritee skipwhite
syn keyword flatTypeInheriteeKeyword managed unmanaged contained nextgroup=flatTypeBlock,flatTypeInheriteeComma skipwhite
syn region flatTypeInheriteeArguments matchgroup=flatDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=flatTypeVariable nextgroup=flatTypeBlock,flatTypeInheriteeComma,flatTypeConstraint,flatTypeConstraintLambdaOperator skipwhite
syn match flatTypeConstraintLambdaOperator /\%#=1=>/ contained nextgroup=flatTypeInheriteeKeyword skipwhite
syn match flatTypeInheriteeMemberAccessOperator /\%#=1\./ contained nextgroup=flatTypeInheritee,flatTypeInheriteeKeyword skipwhite
syn match flatTypeInheriteeComma /\%#=1,/ contained nextgroup=flatTypeInheritee,flatTypeInheriteeKeyword skipwhite
syn keyword flatTypeConstraint where contained nextgroup=flatTypeVariable skipwhite
syn match flatTypeVariable /\%#=1\K\k*/ contained contains=flatKeywordError nextgroup=flatTypeInheritanceOperator skipwhite
syn match flatTypeVariable /\%#=1@\K\k*/ contained nextgroup=flatTypeInheritanceOperator skipwhite
syn region flatTypeBlock matchgroup=flatDelimiter start=/\%#=1{/ end=/\%#=1}/ contained contains=flatStatement,flatModifier,flatType,flatTypeIdentifier,flatBlock,flatComma,flatAttributes,flatOperatorModifier fold

syn keyword flatStatement record nextgroup=flatRecordName,flatRecordModifier skipwhite
syn keyword flatRecordModifier struct class contained nextgroup=flatRecordName skipwhite
syn match flatRecordName /\%#=1\K\k*/ contained contains=flatKeywordError nextgroup=flatTypeBlock,flatRecordProperties,flatTypeInheritanceOperator skipwhite
syn match flatRecordName /\%#=1@\K\k*/ contained nextgroup=flatTypeBlock,flatRecordProperties,flatTypeInheritanceOperator skipwhite
syn region flatRecordProperties matchgroup=flatDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=flatType,flatTypeIdentifier,flatAttributes nextgroup=flatTypeBlock,flatTypeInheritanceOperator skipwhite

syn match flatDestructorSign /\%#=1\~/ contained containedin=flatTypeBlock nextgroup=flatDestructor skipwhite
syn match flatDestructor /\%#=1\K\k*/ contained contains=flatKeywordError nextgroup=flatParameters skipwhite
syn match flatDestructor /\%#=1@\K\k*/ contained nextgroup=flatParameters skipwhite

syn keyword flatStatement enum nextgroup=flatEnumName skipwhite
syn match flatEnumName /\%#=1\K\k*/ contained contains=flatKeywordError nextgroup=flatEnumBlock,flatEnumInheritanceOperator skipwhite
syn match flatEnumName /\%#=1@\K\k*/ contained nextgroup=flatEnumBlock,flatEnumInheritanceOperator skipwhite
syn region flatEnumBlock matchgroup=flatDelimiter start=/\%#=1{/ end=/\%#=1}/ contained contains=flatDeclarator fold

syn keyword flatStatement if switch while nextgroup=flatCondition skipwhite
syn region flatCondition matchgroup=flatDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=@flatRHS nextgroup=flatBlock skipwhite

syn keyword flatStatement else do nextgroup=flatBlock skipwhite

syn keyword flatStatement case nextgroup=@flatPatterns skipwhite

syn keyword flatStatement default

syn keyword flatStatement for foreach nextgroup=flatIteratorExpression skipwhite
syn region flatIteratorExpression matchgroup=flatDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=TOP nextgroup=flatBlock skipwhite

syn keyword flatStatement break continue yield

syn keyword flatStatement goto

syn keyword flatStatement return throw nextgroup=@flatRHS skipwhite

syn keyword flatStatement try finally nextgroup=flatBlock skipwhite
syn keyword flatStatement catch nextgroup=flatCatchCondition skipwhite
syn region flatCatchCondition matchgroup=flatDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=flatTypeIdentifier nextgroup=flatOperatorKeyword,flatBlock skipwhite

syn keyword flatModifier
      \ abstract async external in override

syn keyword flatModifier delegate nextgroup=flatFunctionPointerModifier skipwhite
syn match flatFunctionPointerModifier /\%#=1\*/ contained nextgroup=flatGeneric,flatFunctionPointerManaged skipwhite
syn keyword flatFunctionPointerManaged managed unmanaged contained nextgroup=flatGeneric,flatFunctionPointerTypes skipwhite
syn region flatFunctionPointerTypes matchgroup=flatDelimiter start=/\%#=1\[/ end=/\%#=1\]/ contained contains=flatTypeIdentifier nextgroup=flatGeneric skipwhite

syn keyword flatStatement package import nextgroup=flatGuardedStatement,flatStatement,flatIdentifier,flatModifier skipwhite
syn keyword flatStatement fixed nextgroup=flatGuardedStatement skipwhite
syn region flatGuardedStatement matchgroup=flatDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=TOP

syn keyword flatModifier public visible private static nextgroup=flatConstructor skipwhite
syn match flatConstructor /\%#=1\K\k*(\@=/ contained contains=flatKeywordError nextgroup=flatConstructorParameters
syn match flatConstructor /\%#=1@\K\k*(\@=/ contained nextgroup=flatConstructorParameters
syn region flatConstructorParameters matchgroup=flatDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=flatTypeIdentifier,flatModifier,flatAttributes nextgroup=flatLambdaOperator,flatConstructorInheritanceOperator skipwhite
syn match flatConstructorInheritanceOperator /\%#=1:/ contained nextgroup=flatMethodConstant skipwhite
syn keyword flatMethodConstant this base contained nextgroup=flatMethodConstantParameters skipwhite
syn region flatMethodConstantParameters matchgroup=flatDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=@flatRHS nextgroup=flatLambdaOperator skipwhite

syn keyword flatOperatorModifier operator nextgroup=flatOperatorMethod,flatBooleanOperatorMethod,flatConversionMethod,flatConversionMethodKeyword skipwhite
syn match flatOperatorMethod /\%#=1\%(++\=\|--\=\|[~*/%&|^]\|[=!]=\|<[<=]\=\|>[>=]\=\|\.\.\)/ contained nextgroup=flatParameters skipwhite
syn keyword flatBooleanOperatorMethod true false contained nextgroup=flatParameters skipwhite
syn match flatConversionMethod /\%#=1\K\k*/ contained contains=flatKeywordError nextgroup=flatParameters skipwhite
syn match flatConversionMethod /\%#=1@\K\k*/ contained nextgroup=flatParameters skipwhite
syn keyword flatConversionMethodKeyword contained nextgroup=flatParameters skipwhite

syn keyword flatType nextgroup=flatDeclarator,flatIndexerThis,flatMemberAccessOperator,flatInvocation,flatTypeModifier,flatOperatorModifier skipwhite

syn keyword flatStatement var nextgroup=flatDeclarator skipwhite

syn match flatIdentifier /\%#=1@\=\K\k*\%(<.\{-}>\)\=\%([*?]\.\@!\|\[.\{-}\]\)*/ contains=flatGeneric,flatTypeModifier nextgroup=flatDeclarator,flatIndexerThis,@flatOperators,flatInvocation,flatIndex,flatOperatorModifier,flatPropertyBlock skipwhite
syn region flatGeneric matchgroup=flatDelimiter start=/\%#=1</ end=/\%#=1>/ contained contains=flatType,flatTypeIdentifier,flatModifier nextgroup=flatDeclarator,flatIndexerThis,flatOperatorModifier,flatPropertyBlock skipwhite
syn region flatInvocation matchgroup=flatDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=@flatRHS nextgroup=flatInvocation,flatIndex,@flatOperators skipwhite
syn region flatIndex matchgroup=flatDelimiter start=/\%#=1\[/ end=/\%#=1\]/ contained contains=@flatRHS nextgroup=flatInvocation,flatIndex,@flatOperators skipwhite

syn keyword flatConstant this base nextgroup=@flatOperators,flatInvocation,flatIndex skipwhite

syn keyword flatIndexerThis this contained nextgroup=flatIndexerParameters skipwhite
syn region flatIndexerParameters matchgroup=flatDelimiter start=/\%#=1\[/ end=/\%#=1\]/ contained contains=flatTypeIdentifier,flatModifier nextgroup=flatPropertyBlock,flatLambdaOperator skipwhite

syn match flatDeclarator /\%#=1\K\k*\%(<.\{-}>\)\=/ contained contains=flatKeywordError,flatGenericParameters nextgroup=flatAssignmentOperator,flatLambdaOperator,flatParameters,flatPropertyBlock,flatDeclaratorMemberAccessOperator,flatOperatorKeyword skipwhite
syn match flatNotDeclarator /\%#=1\<\K\k*\%(<.\{-}>\)\=\ze\s*\./ contained containedin=flatDeclarator contains=flatGeneric
syn match flatDeclaratorMemberAccessOperator /\%#=1\./ contained nextgroup=flatDeclarator,flatIdentifier,flatIndexerThis skipwhite
syn region flatParameters matchgroup=flatDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=flatTypeIdentifier,flatModifier,flatThisModifier,flatAttributes nextgroup=flatLambdaOperator,flatBlock,flatMethodTypeConstraint skipwhite
syn keyword flatThisModifier this contained
syn region flatPropertyBlock matchgroup=flatDelimiter start=/\%#=1{/ end=/\%#=1}/ contained contains=flatAccessor,flatModifier nextgroup=flatAssignmentOperator skipwhite fold
syn keyword flatAccessor get set init add remove contained nextgroup=flatBlock,flatLambdaOperator skipwhite
syn match flatComma /\%#=1,/ nextgroup=flatDeclarator skipwhite

syn match flatMethodTypeInheritanceOperator /\%#=1:/ contained nextgroup=flatMethodTypeInheritee,flatMethodTypeInheriteeKeyword skipwhite
syn match flatMethodTypeInheritee /\%#=1\K\k*\%(<.\{-}>\)\=/ contained contains=flatKeywordError,flatGeneric nextgroup=flatMethodTypeInheriteeMemberAccessOperator,flatMethodTypeInheriteeComma,flatMethodTypeConstraint,flatMethodTypeConstraintModifier,flatMethodTypeInheriteeArguments,flatLambdaOperator skipwhite
syn keyword flatMethodTypeInheriteeKeyword contained nextgroup=flatMethodTypeInheriteeComma,flatMethodTypeConstraint,flatMethodTypeConstraintModifier,flatMethodTypeConstraintLambdaOperator skipwhite
      \ class enum default
syn match flatMethodTypeConstraintModifier /\%#=1?/ contained nextgroup=flatMethodTypeInheriteeMemberAccessOperator,flatMethodTypeInheriteeComma,flatMethodTypeConstraint,flatLambdaOperator skipwhite
syn keyword flatMethodTypeInheriteeKeyword new contained nextgroup=flatMethodTypeInheriteeArguments,flatMethodTypeInheritee skipwhite
syn keyword flatMethodTypeInheriteeKeyword managed unmanaged contained nextgroup=flatMethodTypeInheriteeComma,flatLambdaOperator skipwhite
syn region flatMethodTypeInheriteeArguments matchgroup=flatDelimiter start=/\%#=1(/ end=/\%#=1)/ contained nextgroup=flatMethodTypeInheriteeComma,flatMethodTypeConstraint,flatMethodTypeConstraintLambdaOperator skipwhite
syn match flatMethodTypeConstraintLambdaOperator /\%#=1=>/ contained nextgroup=flatMethodTypeInheriteeKeyword skipwhite
syn match flatMethodTypeInheriteeMemberAccessOperator /\%#=1\./ contained nextgroup=flatMethodTypeInheritee,flatMethodTypeInheriteeKeyword skipwhite
syn match flatMethodTypeInheriteeComma /\%#=1,/ contained nextgroup=flatMethodTypeInheritee,flatMethodTypeInheriteeKeyword skipwhite
syn keyword flatMethodTypeConstraint where contained nextgroup=flatMethodTypeVariable skipwhite
syn match flatMethodTypeVariable /\%#=1\K\k*/ contained contains=flatKeywordError nextgroup=flatMethodTypeInheritanceOperator skipwhite
syn match flatMethodTypeVariable /\%#=1@\K\k*/ contained nextgroup=flatMethodTypeInheritanceOperator skipwhite

syn region flatGroup matchgroup=flatDelimiter start=/\%#=1(/ end=/\%#=1)/ contains=@flatRHS,flatRHSTypeIdentifier nextgroup=@flatOperators,flatDeclarator,flatInvocation,flatIndex skipwhite

syn region flatAttributes matchgroup=flatAttributeDelimiter start=/\%#=1\[/ end=/\%#=1\]/ contains=flatAttribute
syn match flatAttribute /\%#=1\K\k*/ contained nextgroup=flatAttributeInvocation skipwhite
syn region flatAttributeInvocation matchgroup=flatDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=@flatRHS

syn match flatAssignmentOperator /\%#=1=/ contained nextgroup=@flatRHS,flatRHSTypeIdentifier,flatInitializer skipwhite

syn match flatLambdaOperator /\%#=1=>/ contained nextgroup=@flatRHS,flatBlock skipwhite

syn match flatMemberAccessOperator /\%#=1?\=\./ contained nextgroup=flatIdentifier,flatConstant skipwhite
syn match flatMemberAccessOperator /\%#=1->/ contained nextgroup=flatIdentifier skipwhite
syn match flatMemberAccessOperator /\%#=1::/ contained nextgroup=flatIdentifier skipwhite

syn match flatNullForgivingOperator /\%#=1!/ contained nextgroup=flatMemberAccessOperator,flatInvocation,flatIndex skipwhite

syn match flatIncrementOperator /\%#=1++/
syn match flatDecrementOperator /\%#=1--/
syn match flatPointerOperator /\%#=1[*&]/

" RHS {{{2
syn cluster flatLiterals contains=
      \ flatNumber,flatBoolean,flatNull,flatRHSConstant,flatCharacter,flatString

syn cluster flatRHS contains=
      \ @flatLiterals,
      \ flatUnaryOperator,flatUnaryOperatorKeyword,flatRHSIdentifier,flatRHSType,
      \ flatRHSGroup,flatFunctionKeyword,flatRHSAttributes

syn cluster flatOperators contains=flatOperator,flatOperatorKeyword,flatComment

syn match flatUnaryOperator /\%#=1++\=/ contained nextgroup=@flatRHS skipwhite
syn match flatUnaryOperator /\%#=1--\=/ contained nextgroup=@flatRHS skipwhite
syn match flatUnaryOperator /\%#=1\.\./ contained nextgroup=@flatRHS skipwhite
syn match flatUnaryOperator /\%#=1[!~*&^]/ contained nextgroup=@flatRHS skipwhite

syn keyword flatUnaryOperatorKeyword await nextgroup=flatStatement,@flatRHS skipwhite
syn keyword flatUnaryOperatorKeyword async contained nextgroup=flatRHSTypeIdentifier,flatRHSType,flatRHSGroup skipwhite
syn keyword flatUnaryOperatorKeyword throw nextgroup=@flatRHS skipwhite
syn keyword flatUnaryOperatorKeyword static contained nextgroup=flatRHSType,flatRHSIdentifier skipwhite

syn keyword flatUnaryOperatorKeyword var let contained nextgroup=flatRHSDeclarator skipwhite
syn match flatRHSDeclarator /\%#=1\K\k*/ contained contains=flatKeywordError nextgroup=@flatOperators skipwhite

syn keyword flatRHSType contained nextgroup=flatMemberAccessOperator,flatRHSGroup,flatRHSIndex,flatRHSDeclarator,flatTypeModifier,flatOperatorKeyword skipwhite

syn match flatRHSIdentifier /\%#=1\K\k*\%(<.\{-}>\)\=/ contained contains=flatKeywordError,flatGeneric nextgroup=@flatOperators,flatRHSInvocation,flatRHSIndex,flatInitializer,flatOperatorModifier skipwhite
syn match flatRHSIdentifier /\%#=1@\K\k*\%(<.\{-}>\)\=/ contained contains=flatGeneric nextgroup=@flatOperators,flatRHSInvocation,flatRHSIndex,flatInitializer,flatOperatorModifier skipwhite
syn region flatRHSInvocation matchgroup=flatDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=@flatRHS nextgroup=@flatOperators,flatInitializer,flatRHSInvocation,flatRHSIndex skipwhite
syn region flatRHSIndex matchgroup=flatDelimiter start=/\%#=1?\=\[/ end=/\%#=1\]/ contained contains=@flatRHS nextgroup=@flatOperators,flatRHSInvocation,flatRHSIndex,flatInitializer skipwhite

syn region flatInitializer matchgroup=flatDelimiter start=/\%#=1{/ end=/\%#=1}/ contained contains=@flatRHS,flatInitializer,flatIndexSetter nextgroup=@flatOperators skipwhite

" The following number patterns were generated by tools/syntax.vim:
syn match flatNumber /\%#=1\.\d\+\%(_\+\d\+\)*\%([eE][+-]\=\d\+\%(_\+\d\+\)*\)\=[fFmMdD]\=\>/ contained nextgroup=@flatOperators skipwhite
syn match flatNumber /\%#=1\d\+\%(_\+\d\+\)*\%(\%([uU][lL]\=\|[lL][uU]\=\)\|[fFmMdD]\|\.\d\+\%(_\+\d\+\)*\%([eE][+-]\=\d\+\%(_\+\d\+\)*\)\=[fFmMdD]\=\|[eE][+-]\=\d\+\%(_\+\d\+\)*[fFmMdD]\=\)\=\>/ contained nextgroup=@flatOperators skipwhite
syn match flatNumber /\%#=10[bB]_*[01]\+\%(_\+[01]\+\)*\%([uU][lL]\=\|[lL][uU]\=\)\=\>/ contained nextgroup=@flatOperators skipwhite
syn match flatNumber /\%#=10[xX]_*\x\+\%(_\+\x\+\)*\%(\%([uU][lL]\=\|[lL][uU]\=\)\|[fFmMdD]\|[eE][+-]\=\d\+\%(_\+\d\+\)*[fFmMdD]\=\)\=\>/ contained nextgroup=@flatOperators skipwhite

syn keyword flatBoolean true false contained nextgroup=@flatOperators skipwhite
syn keyword flatNull null contained nextgroup=@flatOperators skipwhite
syn keyword flatRHSConstant this base contained nextgroup=@flatOperators,flatRHSInvocation,flatRHSIndex skipwhite

syn region flatCharacter matchgroup=flatCharacterDelimiter start=/\%#=1'/ end=/\%#=1'/ oneline contained contains=flatEscapeSequence,flatEscapeSequenceError nextgroup=@flatOperators skipwhite

syn region flatString matchgroup=flatStringStart start=/\%#=1"/    matchgroup=flatStringEnd end=/\%#=1"\%(u8\)\=/ contained contains=flatEscapeSequence,flatEscapeSequenceError,flatStringInterpolation,flatStringInterpolationError nextgroup=@flatOperators skipwhite

syn match flatStringInterpolationError /\%#=1[#]/ contained
syn region flatStringInterpolation matchgroup=flatStringInterpolationDelimiter start=/\%#=1\#{/ end=/\%#=1\%([,:].\{-}\)\=}/ contained contains=@flatRHS

syn match flatEscapeSequenceError /\%#=1\\./ contained
syn match flatEscapeSequence /\%#=1\\\%([#'"\\0abfnrtv]\|x\x\{1,4}\|u\x\{4}\|U\x\{8}\)/ contained

syn match flatQuoteEscape /\%#=1""/ contained
syn match flatBraceEscape /\%#=1{{/ contained
syn match flatBraceEscape /\%#=1}}/ contained

syn match flatOperator /\%#=1!/ contained nextgroup=@flatOperators,flatRHSInvocation,flatRHSIndex skipwhite
syn match flatOperator /\%#=1=/ contained nextgroup=@flatRHS,flatInitializer skipwhite
syn match flatOperator /\%#=1[=!]=/ contained nextgroup=@flatRHS skipwhite
syn match flatOperator /\%#=1[+*/%]=\=/ contained nextgroup=@flatRHS skipwhite
syn match flatOperator /\%#=1=>/ contained nextgroup=@flatRHS,flatBlock skipwhite
syn match flatOperator /\%#=1-[>=]\=/ contained nextgroup=@flatRHS skipwhite
syn match flatOperator /\%#=1++/ contained nextgroup=@flatOperators skipwhite
syn match flatOperator /\%#=1--/ contained nextgroup=@flatOperators skipwhite
syn match flatOperator /\%#=1<<\==\=/ contained nextgroup=@flatRHS skipwhite
syn match flatOperator /\%#=1>>\=>\==\=/ contained nextgroup=@flatRHS skipwhite
syn match flatOperator /\%#=1&&\==\=/ contained nextgroup=@flatRHS skipwhite
syn match flatOperator /\%#=1||\==\=/ contained nextgroup=@flatRHS skipwhite
syn match flatOperator /\%#=1?\%(?=\=\)\=/ contained nextgroup=@flatRHS skipwhite

syn match flatOperator /\%#=1\./ contained nextgroup=flatRHSIdentifier,flatRHSConstant skipwhite
syn match flatOperator /\%#=1\.\./ contained nextgroup=@flatRHS skipwhite
syn match flatOperator /\%#=1?\./ contained nextgroup=flatRHSIdentifier,flatRHSConstant skipwhite
syn match flatOperator /\%#=1:/ contained nextgroup=@flatRHS,flatStatement skipwhite
syn match flatOperator /\%#=1::/ contained nextgroup=flatRHSIdentifier skipwhite

syn region flatRHSGroup matchgroup=flatDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=@flatRHS,flatRHSTypeIdentifier nextgroup=@flatRHS,@flatOperators skipwhite
syn match flatRHSTypeIdentifier /\%#=1\K\k*\%(<.\{-}>\)\=\%([*?]\.\@!\|\[.\{-}\]\)*/ contained contains=flatType,flatKeywordError,flatGeneric,flatTypeModifier nextgroup=@flatOperators,flatRHSGroup,flatRHSIndex skipwhite
syn match flatRHSTypeIdentifier /\%#=1@\K\k*\%(<.\{-}>\)\=\%([*?]\.\@!\|\[.\{-}\]\)*/ contained contains=flatGeneric,flatTypeModifier nextgroup=@flatOperators,flatRHSGroup,flatRHSIndex skipwhite

syn keyword flatOperatorKeyword as contained nextgroup=flatRHSTypeIdentifier skipwhite
syn keyword flatOperatorKeyword in when contained nextgroup=@flatRHS skipwhite

syn keyword flatOperatorKeyword switch contained nextgroup=flatPatternBlock skipwhite
syn region flatPatternBlock matchgroup=flatDelimiter start=/\%#=1{/ end=/\%#=1}/ contained contains=@flatPatterns nextgroup=@flatOperators skipwhite fold

syn cluster flatPatterns contains=flatPatternType,flatPatternTypeIdentifier,flatUnaryOperatorKeyword,@flatLiterals,flatOperator,flatPatternGroup,flatPatternProperties,flatPatternList

syn keyword flatPatternType contained nextgroup=flatPatternDeclarator,flatPatternTypeMemberAccessOperator,flatPatternGroup,flatPatternProperties,flatOperatorKeyword skipwhite

syn match flatPatternTypeIdentifier /\%#=1\K\k*\%(<.\{-}>\)\=/ contained contains=flatGeneric,flatKeywordError nextgroup=flatPatternDeclarator,flatLambdaOperator,flatPatternTypeMemberAccessOperator,flatPatternGroup,flatPatternProperties,flatOperatorKeyword skipwhite
syn match flatPatternTypeIdentifier /\%#=1@\K\k*\%(<.\{-}>\)\=/ contained contains=flatGeneric nextgroup=flatPatternDeclarator,flatLambdaOperator,flatPatternTypeMemberAccessOperator,flatPatternGroup,flatPatternProperties,flatOperatorKeyword skipwhite

syn match flatPatternTypeMemberAccessOperator /\%#=1\./ contained nextgroup=flatPatternTypeIdentifier skipwhite

syn match flatPatternDeclarator /\%#=1\K\k*/ contained contains=flatKeywordError nextgroup=@flatOperators skipwhite
syn match flatPatternDeclarator /\%#=1@\K\k*/ contained nextgroup=@flatOperators skipwhite

syn region flatPatternGroup matchgroup=flatDelimiter start=/\%#=1(/ end=/\%#=1)/ contained contains=@flatPatterns nextgroup=@flatOperators,flatPatternDeclarator,flatPatternProperties skipwhite

syn region flatPatternProperties matchgroup=flatDelimiter start=/\%#=1{/ end=/\%#=1}/ contained contains=flatPatternProperty nextgroup=@flatOperators,flatPatternDeclarator skipwhite
syn match flatPatternProperty /\%#=1\K\k*/ contained contains=flatKeywordError nextgroup=flatPatternPropertyColon,flatPatternPropertyMemberAccessOperator skipwhite
syn match flatPatternProperty /\%#=1@\K\k*/ contained nextgroup=flatPatternPropertyColon,flatPatternPropertyMemberAccessOperator skipwhite
syn match flatPatternPropertyColon /\%#=1:/ contained nextgroup=@flatPatterns skipwhite
syn match flatPatternPropertyMemberAccessOperator /\%#=1\./ contained nextgroup=flatPatternProperty skipwhite

syn region flatPatternList matchgroup=flatDelimiter start=/\%#=1\[/ end=/\%#=1]/ contained contains=@flatPatterns,flatPatternSlice nextgroup=@flatOperators skipwhite
syn match flatPatternSlice /\%#=1\.\./ contained

syn keyword flatOperatorKeyword with contained nextgroup=flatInitializer skipwhite

syn keyword flatFunctionKeyword typeof default checked unchecked sizeof nameof contained nextgroup=flatRHSInvocation skipwhite

syn region flatRHSAttributes matchgroup=flatAttributeDelimiter start=/\%#=1\[/ end=/\%#=1\]/ contained contains=flatAttribute nextgroup=@flatRHS,@flatOperators skipwhite
syn region flatIndexSetter matchgroup=flatDelimiter start=/\%#=1\[/ end=/\%#=1]/ contained contains=@flatRHS nextgroup=flatAssignmentOperator skipwhite

" Miscellaneous (high priority) {{{2
syn region flatComment matchgroup=flatCommentStart start=/\%#=1\/\// end=/\%#=1$/ contains=flatTodo containedin=@flatExtras
syn region flatComment matchgroup=flatCommentStart start=/\%#=1\/\*/ matchgroup=flatCommentEnd end=/\%#=1\*\// contains=flatTodo containedin=@flatExtras
syn region flatComment matchgroup=flatCommentStart start=/\%#=1\/\/\// end=/\%#=1$/ keepend contains=flatTodo containedin=@flatExtras
syn keyword flatTodo TODO NOTE XXX FIXME HACK TBD contained

syn match flatTypeModifier /\%#=1[*?]/ contained nextgroup=flatDeclarator,flatTypeModifier skipwhite
syn region flatTypeModifier matchgroup=flatDelimiter start=/\%#=1\[/ end=/\%#=1\]/ contained contains=@flatRHS nextgroup=flatDeclarator,flatInitializer,flatTypeModifier skipwhite

syn match flatTypeIdentifier /\%#=1\K\k*\%(<.\{-}>\)\=\%([*?]\.\@!\|\[.\{-}\]\)*/ contained contains=flatType,flatKeywordError,flatGeneric,flatTypeModifier nextgroup=flatDeclarator,flatIndexerThis,flatTypeMemberAccessOperator,flatOperatorModifier skipwhite
syn match flatTypeIdentifier /\%#=1@\K\k*\%(<.\{-}>\)\=\%([*?]\.\@!\|\[.\{-}\]\)*/ contained contains=flatGeneric,flatTypeModifier nextgroup=flatDeclarator,flatIndexerThis,flatTypeMemberAccessOperator,flatOperatorModifier skipwhite
syn match flatTypeMemberAccessOperator /\%#=1\./ contained nextgroup=flatTypeIdentifier skipwhite
syn match flatTypeMemberAccessOperator /\%#=1::/ contained nextgroup=flatTypeIdentifier skipwhite

syn cluster flatBlocks contains=flat\a\{-}Block

syn cluster flatExtras contains=
      \ ALLBUT,
      \ flatString,flatCharacter,flatComment,flatEscapeSequenceError

" Highlighting {{{1
hi def link flatComment Comment
hi def link flatCommentStart flatComment
hi def link flatCommentEnd flatCommentStart
hi def link flatTodo Todo
hi def link flatStatement Statement
hi def link flatTypeName Typedef
hi def link flatRecordName flatTypeName
hi def link flatRecordModifier flatStatement
hi def link flatGenericParameter flatDeclarator
hi def link flatTypeInheritanceOperator flatOperator
hi def link flatTypeConstraintLambdaOperator flatOperator
hi def link flatTypeInheriteeMemberAccessOperator flatMemberAccessOperator
hi def link flatTypeConstraint flatStatement
hi def link flatTypeConstraintModifier flatTypeModifier
hi def link flatTypeInheriteeKeyword Keyword
hi def link flatMethodTypeInheritanceOperator flatTypeInheritanceOperator
hi def link flatMethodTypeConstraintLambdaOperator flatTypeConstraintLambdaOperator
hi def link flatMethodTypeInheriteeMemberAccessOperator flatTypeInheriteeMemberAccessOperator
hi def link flatMethodTypeConstraint flatTypeConstraint
hi def link flatMethodTypeInheriteeKeyword flatTypeInheriteeKeyword
hi def link flatMethodTypeConstraintModifier flatTypeConstraintModifier
hi def link flatTypeVariable flatIdentifier
hi def link flatEnumName Typedef
hi def link flatEnumInheritanceOperator flatOperator
hi def link flatDelimiter Delimiter
hi def link flatModifier flatStatement
hi def link flatFunctionPointerModifier flatTypeModifier
hi def link flatOperatorModifier flatModifier
hi def link flatOperatorMethod flatOperator
hi def link flatBooleanOperatorMethod flatBoolean
hi def link flatConversionMethodKeyword flatType
hi def link flatIncrementOperator flatOperator
hi def link flatDecrementOperator flatOperator
hi def link flatPointerOperator flatOperator
hi def link flatType Type
hi def link flatTypeModifier flatOperator
hi def link flatTypeIdentifier flatIdentifier
hi def link flatRHSTypeIdentifier flatTypeIdentifier
hi def link flatTypeMemberAccessOperator flatMemberAccessOperator
hi def link flatDeclarator Identifier
hi def link flatNotDeclarator flatIdentifier
hi def link flatDeclaratorMemberAccessOperator flatMemberAccessOperator
hi def link flatConstructor flatDeclarator
hi def link flatConstructorInheritanceOperator flatOperator
hi def link flatDestructorSign flatOperator
hi def link flatDestructor flatConstructor
hi def link flatMethodConstant flatConstant
hi def link flatConstant Constant
hi def link flatRHSConstant flatConstant
hi def link flatIndexerThis flatConstant
hi def link flatThisModifier flatConstant
hi def link flatOperator Operator
hi def link flatAssignmentOperator flatOperator
hi def link flatMemberAccessOperator flatOperator
hi def link flatNullForgivingOperator flatOperator
hi def link flatLambdaOperator flatOperator
hi def link flatAccessor flatStatement
hi def link flatOperatorKeyword Keyword
hi def link flatUnaryOperatorKeyword flatOperatorKeyword
hi def link flatRHSDeclarator flatDeclarator
hi def link flatRHSIdentifier flatIdentifier
hi def link flatRHSType flatType
hi def link flatUnaryOperator flatOperator
hi def link flatFunctionKeyword Keyword
hi def link flatNumber Number
hi def link flatBoolean Boolean
hi def link flatNull Constant
hi def link flatCharacter Character
hi def link flatCharacterDelimiter flatDelimiter
hi def link flatString String
hi def link flatStringStart flatDelimiter
hi def link flatStringEnd flatStringStart
hi def link flatStringInterpolationDelimiter flatDelimiter
hi def link flatStringInterpolationError Error
hi def link flatEscapeSequence PreProc
hi def link flatEscapeSequenceError Error
hi def link flatQuoteEscape flatEscapeSequence
hi def link flatBraceEscape flatEscapeSequence
hi def link flatAttribute flatIdentifier
hi def link flatAttributeDelimiter flatDelimiter
hi def link flatPatternType flatType
hi def link flatPatternTypeIdentifier flatTypeIdentifier
hi def link flatPatternTypeMemberAccessOperator flatMemberAccessOperator
hi def link flatPatternDeclarator flatDeclarator
hi def link flatPatternPropertyMemberAccessOperator flatMemberAccessOperator
hi def link flatPatternSlice flatOperator
hi def link flatComma flatDelimiter
hi def link flatTypeInheriteeComma flatComma
" }}}1

" vim:fdm=marker
