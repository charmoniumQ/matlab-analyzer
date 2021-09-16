# Generated from MATLAB.g by ANTLR 4.8
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .MATLABParser import MATLABParser
else:
    from MATLABParser import MATLABParser

# This class defines a complete listener for a parse tree produced by MATLABParser.
class MATLABListener(ParseTreeListener):

    # Enter a parse tree produced by MATLABParser#source.
    def enterSource(self, ctx:MATLABParser.SourceContext):
        pass

    # Exit a parse tree produced by MATLABParser#source.
    def exitSource(self, ctx:MATLABParser.SourceContext):
        pass


    # Enter a parse tree produced by MATLABParser#script_file.
    def enterScript_file(self, ctx:MATLABParser.Script_fileContext):
        pass

    # Exit a parse tree produced by MATLABParser#script_file.
    def exitScript_file(self, ctx:MATLABParser.Script_fileContext):
        pass


    # Enter a parse tree produced by MATLABParser#function_file.
    def enterFunction_file(self, ctx:MATLABParser.Function_fileContext):
        pass

    # Exit a parse tree produced by MATLABParser#function_file.
    def exitFunction_file(self, ctx:MATLABParser.Function_fileContext):
        pass


    # Enter a parse tree produced by MATLABParser#statement.
    def enterStatement(self, ctx:MATLABParser.StatementContext):
        pass

    # Exit a parse tree produced by MATLABParser#statement.
    def exitStatement(self, ctx:MATLABParser.StatementContext):
        pass


    # Enter a parse tree produced by MATLABParser#block.
    def enterBlock(self, ctx:MATLABParser.BlockContext):
        pass

    # Exit a parse tree produced by MATLABParser#block.
    def exitBlock(self, ctx:MATLABParser.BlockContext):
        pass


    # Enter a parse tree produced by MATLABParser#while_block.
    def enterWhile_block(self, ctx:MATLABParser.While_blockContext):
        pass

    # Exit a parse tree produced by MATLABParser#while_block.
    def exitWhile_block(self, ctx:MATLABParser.While_blockContext):
        pass


    # Enter a parse tree produced by MATLABParser#for_block.
    def enterFor_block(self, ctx:MATLABParser.For_blockContext):
        pass

    # Exit a parse tree produced by MATLABParser#for_block.
    def exitFor_block(self, ctx:MATLABParser.For_blockContext):
        pass


    # Enter a parse tree produced by MATLABParser#if_block.
    def enterIf_block(self, ctx:MATLABParser.If_blockContext):
        pass

    # Exit a parse tree produced by MATLABParser#if_block.
    def exitIf_block(self, ctx:MATLABParser.If_blockContext):
        pass


    # Enter a parse tree produced by MATLABParser#try_block.
    def enterTry_block(self, ctx:MATLABParser.Try_blockContext):
        pass

    # Exit a parse tree produced by MATLABParser#try_block.
    def exitTry_block(self, ctx:MATLABParser.Try_blockContext):
        pass


    # Enter a parse tree produced by MATLABParser#switch_block.
    def enterSwitch_block(self, ctx:MATLABParser.Switch_blockContext):
        pass

    # Exit a parse tree produced by MATLABParser#switch_block.
    def exitSwitch_block(self, ctx:MATLABParser.Switch_blockContext):
        pass


    # Enter a parse tree produced by MATLABParser#parfor_block.
    def enterParfor_block(self, ctx:MATLABParser.Parfor_blockContext):
        pass

    # Exit a parse tree produced by MATLABParser#parfor_block.
    def exitParfor_block(self, ctx:MATLABParser.Parfor_blockContext):
        pass


    # Enter a parse tree produced by MATLABParser#parfor_parens_block.
    def enterParfor_parens_block(self, ctx:MATLABParser.Parfor_parens_blockContext):
        pass

    # Exit a parse tree produced by MATLABParser#parfor_parens_block.
    def exitParfor_parens_block(self, ctx:MATLABParser.Parfor_parens_blockContext):
        pass


    # Enter a parse tree produced by MATLABParser#function_block.
    def enterFunction_block(self, ctx:MATLABParser.Function_blockContext):
        pass

    # Exit a parse tree produced by MATLABParser#function_block.
    def exitFunction_block(self, ctx:MATLABParser.Function_blockContext):
        pass


    # Enter a parse tree produced by MATLABParser#argument_validentation.
    def enterArgument_validentation(self, ctx:MATLABParser.Argument_validentationContext):
        pass

    # Exit a parse tree produced by MATLABParser#argument_validentation.
    def exitArgument_validentation(self, ctx:MATLABParser.Argument_validentationContext):
        pass


    # Enter a parse tree produced by MATLABParser#return_stmt.
    def enterReturn_stmt(self, ctx:MATLABParser.Return_stmtContext):
        pass

    # Exit a parse tree produced by MATLABParser#return_stmt.
    def exitReturn_stmt(self, ctx:MATLABParser.Return_stmtContext):
        pass


    # Enter a parse tree produced by MATLABParser#break_stmt.
    def enterBreak_stmt(self, ctx:MATLABParser.Break_stmtContext):
        pass

    # Exit a parse tree produced by MATLABParser#break_stmt.
    def exitBreak_stmt(self, ctx:MATLABParser.Break_stmtContext):
        pass


    # Enter a parse tree produced by MATLABParser#continue_stmt.
    def enterContinue_stmt(self, ctx:MATLABParser.Continue_stmtContext):
        pass

    # Exit a parse tree produced by MATLABParser#continue_stmt.
    def exitContinue_stmt(self, ctx:MATLABParser.Continue_stmtContext):
        pass


    # Enter a parse tree produced by MATLABParser#global_stmt.
    def enterGlobal_stmt(self, ctx:MATLABParser.Global_stmtContext):
        pass

    # Exit a parse tree produced by MATLABParser#global_stmt.
    def exitGlobal_stmt(self, ctx:MATLABParser.Global_stmtContext):
        pass


    # Enter a parse tree produced by MATLABParser#assign_stmt.
    def enterAssign_stmt(self, ctx:MATLABParser.Assign_stmtContext):
        pass

    # Exit a parse tree produced by MATLABParser#assign_stmt.
    def exitAssign_stmt(self, ctx:MATLABParser.Assign_stmtContext):
        pass


    # Enter a parse tree produced by MATLABParser#expr_stmt.
    def enterExpr_stmt(self, ctx:MATLABParser.Expr_stmtContext):
        pass

    # Exit a parse tree produced by MATLABParser#expr_stmt.
    def exitExpr_stmt(self, ctx:MATLABParser.Expr_stmtContext):
        pass


    # Enter a parse tree produced by MATLABParser#statement_end.
    def enterStatement_end(self, ctx:MATLABParser.Statement_endContext):
        pass

    # Exit a parse tree produced by MATLABParser#statement_end.
    def exitStatement_end(self, ctx:MATLABParser.Statement_endContext):
        pass


    # Enter a parse tree produced by MATLABParser#lhs_expr.
    def enterLhs_expr(self, ctx:MATLABParser.Lhs_exprContext):
        pass

    # Exit a parse tree produced by MATLABParser#lhs_expr.
    def exitLhs_expr(self, ctx:MATLABParser.Lhs_exprContext):
        pass


    # Enter a parse tree produced by MATLABParser#lhs_array_elem.
    def enterLhs_array_elem(self, ctx:MATLABParser.Lhs_array_elemContext):
        pass

    # Exit a parse tree produced by MATLABParser#lhs_array_elem.
    def exitLhs_array_elem(self, ctx:MATLABParser.Lhs_array_elemContext):
        pass


    # Enter a parse tree produced by MATLABParser#expr.
    def enterExpr(self, ctx:MATLABParser.ExprContext):
        pass

    # Exit a parse tree produced by MATLABParser#expr.
    def exitExpr(self, ctx:MATLABParser.ExprContext):
        pass


    # Enter a parse tree produced by MATLABParser#rest.
    def enterRest(self, ctx:MATLABParser.RestContext):
        pass

    # Exit a parse tree produced by MATLABParser#rest.
    def exitRest(self, ctx:MATLABParser.RestContext):
        pass


    # Enter a parse tree produced by MATLABParser#dotted_or_array_index_or_fn_call.
    def enterDotted_or_array_index_or_fn_call(self, ctx:MATLABParser.Dotted_or_array_index_or_fn_callContext):
        pass

    # Exit a parse tree produced by MATLABParser#dotted_or_array_index_or_fn_call.
    def exitDotted_or_array_index_or_fn_call(self, ctx:MATLABParser.Dotted_or_array_index_or_fn_callContext):
        pass


    # Enter a parse tree produced by MATLABParser#superclass_method.
    def enterSuperclass_method(self, ctx:MATLABParser.Superclass_methodContext):
        pass

    # Exit a parse tree produced by MATLABParser#superclass_method.
    def exitSuperclass_method(self, ctx:MATLABParser.Superclass_methodContext):
        pass


    # Enter a parse tree produced by MATLABParser#function_reference.
    def enterFunction_reference(self, ctx:MATLABParser.Function_referenceContext):
        pass

    # Exit a parse tree produced by MATLABParser#function_reference.
    def exitFunction_reference(self, ctx:MATLABParser.Function_referenceContext):
        pass


    # Enter a parse tree produced by MATLABParser#metaclass.
    def enterMetaclass(self, ctx:MATLABParser.MetaclassContext):
        pass

    # Exit a parse tree produced by MATLABParser#metaclass.
    def exitMetaclass(self, ctx:MATLABParser.MetaclassContext):
        pass


    # Enter a parse tree produced by MATLABParser#lambda_.
    def enterLambda_(self, ctx:MATLABParser.Lambda_Context):
        pass

    # Exit a parse tree produced by MATLABParser#lambda_.
    def exitLambda_(self, ctx:MATLABParser.Lambda_Context):
        pass


    # Enter a parse tree produced by MATLABParser#expr_list.
    def enterExpr_list(self, ctx:MATLABParser.Expr_listContext):
        pass

    # Exit a parse tree produced by MATLABParser#expr_list.
    def exitExpr_list(self, ctx:MATLABParser.Expr_listContext):
        pass


    # Enter a parse tree produced by MATLABParser#paren_expr.
    def enterParen_expr(self, ctx:MATLABParser.Paren_exprContext):
        pass

    # Exit a parse tree produced by MATLABParser#paren_expr.
    def exitParen_expr(self, ctx:MATLABParser.Paren_exprContext):
        pass


    # Enter a parse tree produced by MATLABParser#cell_array.
    def enterCell_array(self, ctx:MATLABParser.Cell_arrayContext):
        pass

    # Exit a parse tree produced by MATLABParser#cell_array.
    def exitCell_array(self, ctx:MATLABParser.Cell_arrayContext):
        pass


    # Enter a parse tree produced by MATLABParser#array.
    def enterArray(self, ctx:MATLABParser.ArrayContext):
        pass

    # Exit a parse tree produced by MATLABParser#array.
    def exitArray(self, ctx:MATLABParser.ArrayContext):
        pass


    # Enter a parse tree produced by MATLABParser#expr_list_cs.
    def enterExpr_list_cs(self, ctx:MATLABParser.Expr_list_csContext):
        pass

    # Exit a parse tree produced by MATLABParser#expr_list_cs.
    def exitExpr_list_cs(self, ctx:MATLABParser.Expr_list_csContext):
        pass


    # Enter a parse tree produced by MATLABParser#index_list.
    def enterIndex_list(self, ctx:MATLABParser.Index_listContext):
        pass

    # Exit a parse tree produced by MATLABParser#index_list.
    def exitIndex_list(self, ctx:MATLABParser.Index_listContext):
        pass


    # Enter a parse tree produced by MATLABParser#index_val.
    def enterIndex_val(self, ctx:MATLABParser.Index_valContext):
        pass

    # Exit a parse tree produced by MATLABParser#index_val.
    def exitIndex_val(self, ctx:MATLABParser.Index_valContext):
        pass


    # Enter a parse tree produced by MATLABParser#ident_list.
    def enterIdent_list(self, ctx:MATLABParser.Ident_listContext):
        pass

    # Exit a parse tree produced by MATLABParser#ident_list.
    def exitIdent_list(self, ctx:MATLABParser.Ident_listContext):
        pass


    # Enter a parse tree produced by MATLABParser#bin_op.
    def enterBin_op(self, ctx:MATLABParser.Bin_opContext):
        pass

    # Exit a parse tree produced by MATLABParser#bin_op.
    def exitBin_op(self, ctx:MATLABParser.Bin_opContext):
        pass


    # Enter a parse tree produced by MATLABParser#pre_unary.
    def enterPre_unary(self, ctx:MATLABParser.Pre_unaryContext):
        pass

    # Exit a parse tree produced by MATLABParser#pre_unary.
    def exitPre_unary(self, ctx:MATLABParser.Pre_unaryContext):
        pass


    # Enter a parse tree produced by MATLABParser#post_unary.
    def enterPost_unary(self, ctx:MATLABParser.Post_unaryContext):
        pass

    # Exit a parse tree produced by MATLABParser#post_unary.
    def exitPost_unary(self, ctx:MATLABParser.Post_unaryContext):
        pass


    # Enter a parse tree produced by MATLABParser#int_.
    def enterInt_(self, ctx:MATLABParser.Int_Context):
        pass

    # Exit a parse tree produced by MATLABParser#int_.
    def exitInt_(self, ctx:MATLABParser.Int_Context):
        pass


    # Enter a parse tree produced by MATLABParser#float_.
    def enterFloat_(self, ctx:MATLABParser.Float_Context):
        pass

    # Exit a parse tree produced by MATLABParser#float_.
    def exitFloat_(self, ctx:MATLABParser.Float_Context):
        pass


    # Enter a parse tree produced by MATLABParser#string.
    def enterString(self, ctx:MATLABParser.StringContext):
        pass

    # Exit a parse tree produced by MATLABParser#string.
    def exitString(self, ctx:MATLABParser.StringContext):
        pass


    # Enter a parse tree produced by MATLABParser#ident.
    def enterIdent(self, ctx:MATLABParser.IdentContext):
        pass

    # Exit a parse tree produced by MATLABParser#ident.
    def exitIdent(self, ctx:MATLABParser.IdentContext):
        pass


    # Enter a parse tree produced by MATLABParser#nl.
    def enterNl(self, ctx:MATLABParser.NlContext):
        pass

    # Exit a parse tree produced by MATLABParser#nl.
    def exitNl(self, ctx:MATLABParser.NlContext):
        pass



del MATLABParser