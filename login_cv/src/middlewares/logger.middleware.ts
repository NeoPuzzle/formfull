import { NextFunction, Request, Response } from "express";


export function loggerGlobal(req: Request, res: Response, next: NextFunction) {
    console.log(`Path: ${req.path} - Method: ${req.method} - Time: ${new Date().toLocaleString()}`);
    next();
}