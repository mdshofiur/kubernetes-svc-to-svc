"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getUsers = void 0;
// import fs from 'fs';
// import path from 'path';
const axios_1 = __importDefault(require("axios"));
// const userFilePath = path.join(__dirname, '../fake-data/users.json');
const getUsers = () => __awaiter(void 0, void 0, void 0, function* () {
    try {
        // const rawData = await fs.promises.readFile(userFilePath, 'utf-8');
        // return JSON.parse(rawData);
        const response = yield axios_1.default.get('https://jsonplaceholder.typicode.com/users');
        return response.data;
    }
    catch (error) {
        console.error('Error reading user data:', error);
        return [];
    }
});
exports.getUsers = getUsers;
