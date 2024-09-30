import React from 'react'
import { useState } from 'react';
export default function Signup() {
    const [name, setName]=useState("");
    const [email, setEmail]=useState("");
    const [password, setPassword]=useState("");
    const [password_confirmation, setConfirmPassword]=useState("");

    function submit() {
        const myHeaders = new Headers();
        myHeaders.append("Content-Type", "application/json");
        const raw = JSON.stringify({
            "user": { name, email, password, password_confirmation }
        });

        const requestOptions = {
            method: "POST",
            headers: myHeaders,
            body: raw,
            redirect: "follow"
        };

        fetch("http://localhost:8000/registrations", requestOptions)
            .then(async (response) => await response.json())
            .then((result) => {
                if(result.user){
                    alert("User registered successfully !");
                }
                else{
                    alert("Error status: ",result.status);
                }
            })
            .catch((error) => alert(error));
    }
    return (
        <>
            <div className="w-1/4 mx-auto border border-2 p-5 rounded-lg shadow-xl">
                <div className="mb-5">
                    <label for="name" className="block mb-2 text-sm font-medium text-gray-900">Your name</label>
                    <input type="text" id="name" className="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" value={name} onChange={(e)=>setName(e.target.value)} required />
                </div>
                <div className="mb-5">
                    <label for="email" className="block mb-2 text-sm font-medium text-gray-900">Your email</label>
                    <input type="email" id="email" className="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" placeholder="name@flowbite.com" value={email} onChange={(e)=> setEmail(e.target.value)} required />
                </div>
                <div className="mb-5">
                    <label for="password" className="block mb-2 text-sm font-medium text-gray-900">New password</label>
                    <input type="password" id="password" className="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" value={password} onChange={(e)=>setPassword(e.target.value)} required />
                </div>
                <div className="mb-5">
                    <label for="confirmpassword" className="block mb-2 text-sm font-medium text-gray-900">Confirm password</label>
                    <input type="password" id="confirmpassword" className="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" value={password_confirmation} onChange={(e)=> setConfirmPassword(e.target.value)} required />
                </div>
                <button className="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center" onClick={submit}>Sign up</button>
            </div>
        </>
    )
}